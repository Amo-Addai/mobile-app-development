import { StatusBar as ExpoStatusBar } from 'expo-status-bar';
import { 
  StyleSheet,
  Text,
  View,
  SafeAreaView,
  // StatusBar,
  // Platform,
} from 'react-native';

export default function App() {
  return (
    <>
      <SafeAreaView style={styles.container}>
        <View style={styles.search}>
          <Text>search</Text>
        </View>
        <View style={styles.list}>
          <Text>list</Text>
        </View>
      </SafeAreaView>
      <ExpoStatusBar style="auto" />
    </>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1 },
  search: { padding: 16, backgroundColor: "green" },
  list: { flex: 1, padding: 16, backgroundColor: "blue" },
});
