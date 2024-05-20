Return-Path: <linux-pwm+bounces-2181-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100188C9819
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 05:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E6B1C20F86
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 03:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1003F505;
	Mon, 20 May 2024 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Zaoofn8G"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6DD52E
	for <linux-pwm@vger.kernel.org>; Mon, 20 May 2024 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716174218; cv=none; b=PJF+ht09mtW271EuEa4ZT9wP7Jc4p8U9BqavEyoErQ16PQzAlNCysHrWqkBAi4NO7kU89tbOHJZVOnnXqAfI4FxJgreeaqV7JaDLNy3Yf9bKptN1kxViWMT+icK0vdEW7X18XdEjZq6HTUmaA+L6YJQA0SbwmetKXDHh5YhQG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716174218; c=relaxed/simple;
	bh=IGj5kRKmq3n+WvTh+8fKpl07otq/0zDRJPWb+zfXshc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxRzZ+NTsauvWUPx2vEZ+d8cXMAMi9N0fuo2VTCU6M9HZZ6dT043C4L0rd8Ctv7aalKXWtzV5PsXyySPI7UpTiW/8Sh3rSF+VnPXSSnsWbVwCIZ9WqKdtEQKKtkdAdzufm650ZRcOpJlmkx1vNGHsd+4tf9FndZ72oMfUh7U3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Zaoofn8G; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C27472C061C;
	Mon, 20 May 2024 15:03:26 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1716174206;
	bh=b9qzEaQJl1Fq0z1Dc4J4cdeNmSzNgDpWQiImhbo4eN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zaoofn8G6Br/cFFjD9ge1Zd/mw0CpDVC4UOctapKzSpw42vpkowtEWD7zzDIc+Srh
	 vVnXewdi2+OPKhwIdvaPzB462kjRXkp3r5Fv+W8/eUgjf+dFyayj/kHO/4r61JNjqN
	 cxmIB7gsDyWZwA+x+TsOu0ZaGz8tqLIpuvgBa5/OWeyH17zHT2YibVh1RgXWaHt8y8
	 HmyrMYJZsewn4J3IqW++jex50oHyxqKeGPKkh3bCn4RDBbv+QVARF2MlgE053/8ASd
	 6OvCXsHUE54c5+NRIgEaWuZM+fIBkTdvBLXqIdl/g66hVLBoyinc1RM253Pn0cppq/
	 53+TyvOD5Ug4A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B664abd7e0003>; Mon, 20 May 2024 15:03:26 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 67C8913EE4F;
	Mon, 20 May 2024 15:03:26 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 651FA280C1C; Mon, 20 May 2024 15:03:26 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ukleinek@kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 3/3] hwmon: (adt7475) Add support for configuring initial PWM state
Date: Mon, 20 May 2024 15:03:21 +1200
Message-ID: <20240520030321.3756604-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520030321.3756604-1-chris.packham@alliedtelesis.co.nz>
References: <20240520030321.3756604-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=664abd7e a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=TpHVaj0NuXgA:10 a=p7mM90n0AGoxUC-S2eYA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

By default the PWM duty cycle in hardware is 100%. On some systems this
can cause unwanted fan noise. Add the ability to specify the fan
connections and initial state of the PWMs via device properties.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - Use the pwm provider/consumer bindings
    Changes in v2:
    - Use correct device property string for frequency
    - Allow -EINVAL and only warn on error
    - Use a frequency of 0 to indicate that the hardware should be left a=
s-is

 drivers/hwmon/adt7475.c | 63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 4224ffb30483..2b8f39c1d76f 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -21,6 +21,8 @@
 #include <linux/of.h>
 #include <linux/util_macros.h>
=20
+#include <dt-bindings/pwm/pwm.h>
+
 /* Indexes for the sysfs hooks */
=20
 #define INPUT		0
@@ -1662,6 +1664,63 @@ static int adt7475_set_pwm_polarity(struct i2c_cli=
ent *client)
 	return 0;
 }
=20
+static int adt7475_fan_pwm_config(struct i2c_client *client)
+{
+	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct fwnode_handle *child;
+	struct of_phandle_args args =3D {};
+	int ret, pwm, duty, freq, flags;
+	u8 val;
+
+	device_for_each_child_node(&client->dev, child) {
+		if (!is_of_node(child))
+			continue;
+
+		ret =3D of_parse_phandle_with_args(to_of_node(child), "pwms", "#pwm-ce=
lls", 0, &args);
+		if (ret)
+			return ret;
+
+		if (args.args_count !=3D 4)
+			return -EINVAL;
+
+		pwm =3D args.args[0];
+		freq =3D find_closest(args.args[1], pwmfreq_table, ARRAY_SIZE(pwmfreq_=
table));
+		flags =3D args.args[2];
+		duty =3D clamp_val(args.args[3], 0, 0xFF);
+
+		if (pwm >=3D ADT7475_PWM_COUNT)
+			return -EINVAL;
+
+		ret =3D adt7475_read(PWM_CONFIG_REG(pwm));
+		if (ret < 0)
+			return ret;
+		val =3D ret;
+		if (flags & PWM_POLARITY_INVERTED)
+			val |=3D BIT(4);
+		else
+			val &=3D ~BIT(4);
+
+		ret =3D i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(pwm), val);
+		if (ret)
+			return ret;
+
+		data->pwm[pwm][0] =3D duty;
+		ret =3D i2c_smbus_write_byte_data(client, PWM_REG(pwm), data->pwm[pwm]=
[0]);
+		if (ret)
+			return ret;
+
+		data->range[pwm] =3D adt7475_read(TEMP_TRANGE_REG(pwm));
+		data->range[pwm] &=3D ~0xf;
+		data->range[pwm] |=3D freq;
+
+		ret =3D i2c_smbus_write_byte_data(client, TEMP_TRANGE_REG(pwm), data->=
range[pwm]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int adt7475_probe(struct i2c_client *client)
 {
 	enum chips chip;
@@ -1778,6 +1837,10 @@ static int adt7475_probe(struct i2c_client *client=
)
 	if (ret && ret !=3D -EINVAL)
 		dev_warn(&client->dev, "Error configuring pwm polarity\n");
=20
+	ret =3D adt7475_fan_pwm_config(client);
+	if (ret)
+		dev_warn(&client->dev, "Error %d configuring fan/pwm\n", ret);
+
 	/* Start monitoring */
 	switch (chip) {
 	case adt7475:
--=20
2.45.1


