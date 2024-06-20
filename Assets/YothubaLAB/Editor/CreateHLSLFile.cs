using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public class CreateHLSLFile
{
    [MenuItem("Assets/Create/Shader/HLSL File", false, 100)]
    public static void Create()
    {
        var selectedAsset = Selection.activeObject;
        string selectedPath = AssetDatabase.GetAssetPath(selectedAsset);
        
        if (selectedAsset == null || string.IsNullOrEmpty(selectedPath))
        {
            selectedPath = "Assets";
        }

        string fullPath = Path.Combine(selectedPath, "NewHLSLFile.hlsl");
        fullPath = AssetDatabase.GenerateUniqueAssetPath(fullPath);
        
        File.WriteAllText(fullPath, string.Empty);
        
        AssetDatabase.Refresh();
    }
}
