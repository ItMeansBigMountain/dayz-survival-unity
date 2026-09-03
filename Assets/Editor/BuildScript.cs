using UnityEngine;
using UnityEditor;
using UnityEditor.Build.Reporting;

public static class BuildScript
{
    public static void PerformWebGLBuild()
    {
        string[] scenes = { "Assets/Scenes/Main.unity" };
        string outputPath = "Builds/WebGL";

        BuildPlayerOptions buildPlayerOptions = new BuildPlayerOptions
        {
            scenes = scenes,
            locationPathName = outputPath,
            target = BuildTarget.WebGL,
            options = BuildOptions.None
        };

        BuildReport report = BuildPipeline.BuildPlayer(buildPlayerOptions);
        BuildSummary summary = report.summary;

        if (summary.result == BuildResult.Succeeded)
        {
            Debug.Log($"Build succeeded: {outputPath}");
        }
        else
        {
            Debug.LogError($"Build failed: {summary.totalErrors} errors");
            foreach (var step in report.steps)
            {
                foreach (var message in step.messages)
                {
                    if (message.type == LogType.Error)
                        Debug.LogError(message.content);
                }
            }
            throw new System.Exception("WebGL build failed");
        }
    }
}