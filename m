Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887931D684F
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 15:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgEQN4G (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 09:56:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:63618 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgEQN4G (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 17 May 2020 09:56:06 -0400
IronPort-SDR: c8vWnafTwLpLHwrVsy6fz1VZE6QYhBpMnMAt0cAc8KDWWCyts52bXwIp+aAYisH4v7L9CWPP3B
 KknhD5pFYEng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 06:56:05 -0700
IronPort-SDR: AGPBszLxSSwLV3hA7431pYcv6Zx87W+e8yV4IXp8bxfls3UhTBSPJhQ1mXdPtYPRqORmDPak8L
 TAOxZI8S4VIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,403,1583222400"; 
   d="scan'208";a="263694151"
Received: from vgjayaku-ilbpg7.png.intel.com ([10.88.227.96])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2020 06:56:03 -0700
From:   vineetha.g.jaya.kumaran@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@intel.com, vineetha.g.jaya.kumaran@intel.com
Subject: [PATCH 1/3] pwm: Add count attribute in sysfs for Intel Keem Bay
Date:   Sun, 17 May 2020 21:52:38 +0800
Message-Id: <1589723560-5734-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: "Lai, Poey Seng" <poey.seng.lai@intel.com>

In Keem Bay, the number of repetitions for the period/waveform
can be configured from userspace. This requires addition of a sysfs
attribute to get/set the repetition count. Setting this value to 0
will result in continuous repetition of the waveform until the
channel is disabled or reconfigured.

Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
---
 Documentation/ABI/testing/sysfs-class-pwm |  9 ++++++++
 drivers/pwm/core.c                        |  3 ++-
 drivers/pwm/sysfs.c                       | 37 +++++++++++++++++++++++++++++++
 include/linux/pwm.h                       |  2 ++
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-pwm b/Documentation/ABI/testing/sysfs-class-pwm
index c20e613..87e219f 100644
--- a/Documentation/ABI/testing/sysfs-class-pwm
+++ b/Documentation/ABI/testing/sysfs-class-pwm
@@ -86,3 +86,12 @@ Description:
 		Capture information about a PWM signal. The output format is a
 		pair unsigned integers (period and duty cycle), separated by a
 		single space.
+
+What:		/sys/class/pwm/pwmchipN/pwmX/count
+Date:		May 2020
+KernelVersion:	5.6
+Contact:	Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
+Description:
+		Sets the repetition count of a PWM waveform. A value of 0 will
+		result in continuous repetition of the waveform until the
+		channel is disabled or reconfigured.
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index bca0496..fd42fb6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -584,7 +584,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	if (state->period == pwm->state.period &&
 	    state->duty_cycle == pwm->state.duty_cycle &&
 	    state->polarity == pwm->state.polarity &&
-	    state->enabled == pwm->state.enabled)
+	    state->enabled == pwm->state.enabled &&
+	    state->count == pwm->state.count)
 		return 0;
 
 	if (chip->ops->apply) {
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 2389b86..3c474fa 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -215,11 +215,47 @@ static ssize_t capture_show(struct device *child,
 	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
 }
 
+static ssize_t count_store(struct device *child,
+			      struct device_attribute *attr,
+			      const char *buf, size_t size)
+{
+	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.count = val;
+	ret = pwm_apply_state(pwm, &state);
+	mutex_unlock(&export->lock);
+
+	return ret ? : size;
+}
+
+static ssize_t count_show(struct device *child,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	const struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return sprintf(buf, "%d\n", state.count);
+}
+
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
 static DEVICE_ATTR_RO(capture);
+static DEVICE_ATTR_RW(count);
 
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
@@ -227,6 +263,7 @@ static ssize_t capture_show(struct device *child,
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
 	&dev_attr_capture.attr,
+	&dev_attr_count.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 2635b2a..c874559 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -52,12 +52,14 @@ enum {
  * struct pwm_state - state of a PWM channel
  * @period: PWM period (in nanoseconds)
  * @duty_cycle: PWM duty cycle (in nanoseconds)
+ * @count: Repeat count of PWM waveforms.
  * @polarity: PWM polarity
  * @enabled: PWM enabled status
  */
 struct pwm_state {
 	unsigned int period;
 	unsigned int duty_cycle;
+	unsigned int count;
 	enum pwm_polarity polarity;
 	bool enabled;
 };
-- 
1.9.1

