Return-Path: <linux-pwm+bounces-3260-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC4B978489
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF45AB26B6C
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2551C5785;
	Fri, 13 Sep 2024 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqtG5sjD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896E01C3F30;
	Fri, 13 Sep 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240175; cv=none; b=qnNEYSB1a5xLPs0sDfIpXR986lhd2I9snSKjKQdM2G/LRoy36wdmESYAAUocnMavoOvgBECrVBAGoBRhGnHzRM0wG5rGmQIIoWnmRodabhjAWCbGUvY/d7uuSd3+FdfviqYLnbQYIdDxuVhQFqmp+X/4xhvy9Puh5Pz0bDnJKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240175; c=relaxed/simple;
	bh=sotlZbQi5UxMTXTY9iQWeBGitc5Ct0BtuZ2yW6i8Nok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNp+hW1d1PgsGFhK5D7e2RqyNGNAhD6Cmr5ocg6ziPLmseic6XHGkjcaTIe20Ec6kj4002Q46NVVExSRfVNqqn6Jn738mX6ABG1vUp2V4LBk1bPSaoMxGgYR5hsly/UxEWlq2t1Dg4VRnJlKXUIzFvnFI30yLftOzpCSj3E/pSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqtG5sjD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so2944448a12.3;
        Fri, 13 Sep 2024 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240171; x=1726844971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXJIkSLw8SmFch9ZUCSaWYebLdfaycyre/4lwJqktRc=;
        b=QqtG5sjD75MPPTL9uxDFdApVZ3+r7KD2KL0iNEd7Js90da5B8v2G7y+/hyWDKlV5rX
         3Fztu+Wr2ICdSY2o/ip5d3KH8+xusrmEk4hGscNhCdvFluwf/bmjeOVoL8nh2Ixdb9IJ
         8U3CtH+hvCV76li6tt5eG48Gg8AHVZvQlRHh8Iy1dsORWODQX5jFUWiWqOMInp9PIMAH
         Eam4aRySDKUWLk1mcEu1RA6JcvJ5gyFy+57gK4h1j2AScZLQbGYtM+Xs1NvdELKUDhmk
         VuhKzTAeL7kuvMrIK55UaKutlSNNDmXIDkoTqOUNNL/vrl+yneS+sZaOlU7w6poRuwn5
         7baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240171; x=1726844971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXJIkSLw8SmFch9ZUCSaWYebLdfaycyre/4lwJqktRc=;
        b=J9s27h1UUGLr84U5/yAyZJsgI6gwTHTQQ+vx/u51IwWj7gqz1CmyTrroV5jq8Uh2kr
         E6u/R847+cr5r/nQ2cV7iHoiZ/O8Tnuqm1jUfKDhRIJ/WZF6sKhlzSzO04n2OS86LbR0
         EUfQ2zyMBYDHXc6Q4qcMzz39U9NEvPDWHumLR14W95EsHaqGt0qOc1T96vkXLvxGZDoi
         R5rnELotNTtDWaSnFytAWVM0bOaJ7FdMiB9fpweo4LiQ3ATYKmZdbNBA+ImhCfSjQ0Ch
         6NmICZQIdot3wAagTOVaiWzPG5FK7xN17aQ/feXCCjFm8oGKxBLN0/GNL+ae640xuK/z
         0wHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhCX0BAMk05IyBLSQutDLJfVWTFswx9F6GWd198LSABd381GBIIaofuv+n3Fa5lFEPdxdJepGB/ueakzc=@vger.kernel.org, AJvYcCUuti24ziJKj2yZFdgTlk5qdVp945GGwnleaoFOwvGYAgF7kM/9o3AZlWOLxs+cYjH4P6bgysgzQEM9drJk@vger.kernel.org, AJvYcCV/qB5ttufj9m/e1++oHyIrcBu/Jt7mXBsrsWZpW93JbSKj/Zx9IYSZWtbqcNxF6T8URIhVfGCxA7YUd61q3DF5fE0=@vger.kernel.org, AJvYcCVkbNcUFQEropyKy8NfbbsMNZ0QFvOOxr1HnVH6jZrBzr082ilPdQ9RkssS8xkcR+35Qbb7GX9WOIsQu46sKg==@vger.kernel.org, AJvYcCWkJ1fxPDQw+F8r8yx7Po3+bsO/Ie2HEvDLachSkDhlUvGLdF0gIqwUzuNz3Ji0C3TXXVK+1MAIYtX+@vger.kernel.org, AJvYcCXJHZsaa+Lap0z/vITRjAjE62GtCcTohp03NyLwF6TsIf9FuM6fHeZe2uwiRnsoxTVQn7RploJGBy5rBw==@vger.kernel.org, AJvYcCXJnUnKOXJwgWI/0HxHCnRFJ6i5GZUP9VgPjkF/qb/TieQqREoyTLOspdurnGLOHPfqyNQSodpmpsci@vger.kernel.org, AJvYcCXt0cotO6XZozI3melRYob9QNcTS0GS2D4FCOYxAwa1B0Sgm/cZTNkjEey2pOgXjSPttPPrsaluxiW0@vger.kernel.org
X-Gm-Message-State: AOJu0YxuhtrqkE/IfZ68GjJMK0tVXPbHrxcDBj+ASAUTOSw7C4Nva94o
	ajFXxhiT6NXbFfN+Y1dTeTE+SQ9dGLGsQrG0J2viUkESwvG/xvQyBeZVeA==
X-Google-Smtp-Source: AGHT+IGyk1J+WrXxg3n6en6ZybXZ+SEJzAfSUZQA055wEMUefoWDRM5H6YgIPbZdZbXXjvmPnSljDQ==
X-Received: by 2002:a05:6402:35c1:b0:5c4:181a:6b0a with SMTP id 4fb4d7f45d1cf-5c4181a6b7dmr4656181a12.10.1726240171482;
        Fri, 13 Sep 2024 08:09:31 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:31 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:08:10 +0300
Subject: [PATCH v4 27/27] arm64: dts: qcom: starqltechn: add modem support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-27-2d2efd5c5877@gmail.com>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 Simona Vetter <simona@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=2030;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=sotlZbQi5UxMTXTY9iQWeBGitc5Ct0BtuZ2yW6i8Nok=;
 b=2OY/1Wou8Los9DL2QaeQkDbKQavhO22dQvFX7va+9W+VFm6Zwxp1qTyqVIttAEcQn/XWN02FC
 mMW9IBedqIOB+8AWBDGbU1ksLCmuAtMW2nQ+hhGKetema4Hwj+gR7YU
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add support for modem and ipa(IP Accelerator).
Add spss reserved memory node.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 2710386a89e1..4614ec5f731f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -17,6 +17,8 @@
 #include "pm8998.dtsi"
 #include "sdm845-wcd9340.dtsi"
 
+/delete-node/ &rmtfs_mem;
+/delete-node/ &spss_mem;
 /delete-node/ &adsp_mem;
 /delete-node/ &slpi_mem;
 
@@ -91,15 +93,39 @@ memory@a1300000 {
 			pmsg-size = <0x40000>;
 		};
 
+		/*
+		 * It seems like reserving the old rmtfs_mem region is also needed to prevent
+		 * random crashes which are most likely modem related, more testing needed.
+		 */
+		removed_region: removed-region@88f00000 {
+			reg = <0 0x88f00000 0 0x1c00000>;
+			no-map;
+		};
+
 		slpi_mem: slpi@96700000 {
 			reg = <0 0x96700000 0 0xf00000>;
 			no-map;
 		};
 
+		spss_mem: spss@97700000 {
+			reg = <0 0x97700000 0 0x100000>;
+			no-map;
+		};
+
 		adsp_mem: memory@97800000 {
 			reg = <0 0x97800000 0 0x2000000>;
 			no-map;
 		};
+
+		rmtfs_mem: rmtfs-mem@fde00000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0xfde00000 0 0x202000>;
+			qcom,use-guard-pages;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
+		};
 	};
 
 	gpio_keys {
@@ -837,6 +863,19 @@ dai@5 {
 	};
 };
 
+&mss_pil {
+	firmware-name = "qcom/sdm845/starqltechn/mba.mbn",
+			"qcom/sdm845/starqltechn/modem.mbn";
+	status = "okay";
+};
+
+&ipa {
+	qcom,gsi-loader = "self";
+	memory-region = <&ipa_fw_mem>;
+	firmware-name = "qcom/sdm845/starqltechn/ipa_fws.mbn";
+	status = "okay";
+};
+
 &usb_1 {
 	status = "okay";
 };

-- 
2.39.2


