Return-Path: <linux-pwm+bounces-6781-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D265CAFD526
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BE23A641C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69C22DAFAE;
	Tue,  8 Jul 2025 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GY/RNe1U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC99F9E8
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995149; cv=none; b=dlBrGTXH30UktqBV7MlPjE63GCEvBZy0E6gxgklm+H49xhJx17SSQTqwgclk6TLLgAt1ZESqsWfXF9Ls1/rRc/YnSkffJ91O92K1nlFpvrR6Tz1YLYmwOM9EoMlo9bzSQbvtqwzRbJHjbLYd7hx6U8LV2nNSue3IYRDIJFIuUTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995149; c=relaxed/simple;
	bh=T2A0/9nlYAI6voHfpJH7Rb1hXChRfttt5tHMxIzKo0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0PrLyLrjZAsl81PtUg+YQLAT6fHLiITX8gGPYPH4E/FwVyBT+7sudACybkVUv4rsPWNWRtslN6Gfb+ePGptoWRHy+hU56c07IBcDXHePA6qFe73KzXgVXKgWSlsQEbhZSRMt2Rko6k7NAyuOmPrGkhA81lUrx8hy1EuGtBxfnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GY/RNe1U; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so737240966b.3
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995146; x=1752599946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scqIja4yXt3y0BO/CrmZ2a1K+cZsnX2h0lseDNvoEkQ=;
        b=GY/RNe1UcaTWJcGdDwLhyhFGNRI1yC6sfXsZSvLVtRHOSI0L+QibXXrQoMjeSIExqy
         Z5rOsOoKcp8Ftx9xpqdeOy8YGn7/XN9to0MaTzMi0lJdhzOIG3krLy0dwkv7nJN8Fk5h
         xbaY087ii81G+4rVzm3WAem6dNeWlaOZbimxa1rBx05H+DcHUb+lzxteXwbn5FC+JkUX
         cMdn+7TNIGN3f/v1AH7EJ+eoKmO9QJZMTfcXLvNoY7f4C8c6fqo8S3WY1ihrQxQb6Iha
         j7FHJdHDDZ2gHXXmN6HMrMvjDUvA/AWRVPZdBEVC51eRqdlOuyBc3PQMCMFVdiglutxd
         ExWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995146; x=1752599946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scqIja4yXt3y0BO/CrmZ2a1K+cZsnX2h0lseDNvoEkQ=;
        b=SQYvDqiSt+v9C/vY7Qfi4rSsiv8SfI1T5O2R1tz961+znukTuH3fYWBjWNn7Gp3BmQ
         lEvYGbw6fh1RjOPngtio+LQ6bmigNNB8C6vKVFVvBT2c2CwPwXy07oN9z54Ql9AUmsE5
         okfzo27vGVQYyClppvfMkl6JJW/HFAepGwNSny/v/JVfzWiirLP0ThGiiEOKJT6ihGp7
         4mjG6kWIwz07KjKbvgSo8asDaPa7KWUfNztdGoFe6yU2KDQ5pNMCxvnMyY5Fly3sNZ5r
         zMPW5h0asVzyKotaBQ5PWRO7DcKmUDJE5crNIg1zC6cMsNDpEWWH8wX9o1hTLpdi3cbu
         Nv2Q==
X-Gm-Message-State: AOJu0YyB9K6JgqqxJpOR6ud9GV7gmfrbwSRblgXrCgKYaYxpT/5abws3
	DCrRD5W7WDRFh5+MdpTjBJzn4caDIqvm10zfaucBOj9P6DGHroCKVEmJNTpUfOvRiGg=
X-Gm-Gg: ASbGncuS02Q7FJyhXwEBOeYpRdpdaXEtNoHNOEdJG5nyrP+zS4LbFUAYGTXk6jFQyXH
	ewZ79vDmyIgiFau3e7RYkgQhy1UfLy5PaqaZCu5j6x68hnWWCBlMRM6Xir/FTLCAuxNT8gGiR/Z
	P45/VHZi5tWOawDlxDKMgv/grSsX3HwWXYvSHLtUTklpopzvb0i23LZ+IW7uMsH71CW7WVD3Dup
	bs5sKa0AQ+QbPmBEW3hzZ+MsabwxOLjncnvN3DtGjvMlwllko0ZGOuNAPnxdR2MVgJIdsIVxH2n
	51mALqu53tE0R2lwYCzonV5RHK8x/6YhOCIUWkLuy6fMb3/X92XtIVnrsn/Cbc8OsSJQprUGgV5
	bejgfPtzfHbgxdzL6g5MO6Cs0rY5I
X-Google-Smtp-Source: AGHT+IE5OIeIZ5QR1ZssvGG6cwfSQTYFY8oEnTXJsjzZL/KNsWCagxV2uvWNHzT/jpCoBE+QF2QW+w==
X-Received: by 2002:a17:907:724d:b0:ae3:60fb:1b3b with SMTP id a640c23a62f3a-ae3fe82f933mr596168966b.58.1751995146037;
        Tue, 08 Jul 2025 10:19:06 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f6b5e7d5sm925568566b.151.2025.07.08.10.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:19:05 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/8] pwm: mediatek: Introduce and use a few more register defines
Date: Tue,  8 Jul 2025 19:18:32 +0200
Message-ID:  <1f1078375a1c7ef97d7b4fa3d1c59a16465ce535.1751994509.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
References: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=T2A0/9nlYAI6voHfpJH7Rb1hXChRfttt5tHMxIzKo0Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVLu4yyc4ZEXE2Flt1EFiMsFvTCqvJ8gMPVO1 FCTHsNA6muJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1S7gAKCRCPgPtYfRL+ TpkoCACy5J6jHwSO9DH+RD0l/OD8lEXDGK8YCOAIDTeaMsT7FeKoFSG2MyJlXwnLli3dQW3ZvyL VoOXPJCCJ0aJkzeVN7Ewln2X0lgZFKeLGV/nFbrTnMZd5YCZWTp5p0JzeTgkhNdYigCmoMpU++s 3LLDBYXcIjaQy2whOrRWaOrkBQncTwlk7HQUI+ml+UWU2maQd4h7JoPFqK2D/no6yZA0MvQ7eXk 65Ui3cG2q2xXZZLaS41bGK5mQon9EZm/zdbSNIEURuA1mgX3hAgX7WQNpmL9eIc2UD03ve2gSOX Ji5bTPbbhK+/e+Bc0eCXs8EFSs/bMvnaHGcOfe6CSKNDcPTi
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Instead of using a magic constant for bound checking, derive the numbers
from appropriate register defines.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index a816f136f39d..4e2a27b02c80 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
@@ -21,19 +22,19 @@
 
 /* PWM registers and bits definitions */
 #define PWMCON			0x00
+#define PWMCON_CLKDIV			GENMASK(2, 0)
 #define PWMHDUR			0x04
 #define PWMLDUR			0x08
 #define PWMGDUR			0x0c
 #define PWMWAVENUM		0x28
 #define PWMDWIDTH		0x2c
+#define PWMDWIDTH_PERIOD		GENMASK(12, 0)
 #define PWM45DWIDTH_FIXUP	0x30
 #define PWMTHRES		0x30
 #define PWM45THRES_FIXUP	0x34
 #define PWM_CK_26M_SEL_V3	0x74
 #define PWM_CK_26M_SEL		0x210
 
-#define PWM_CLK_DIV_MAX		7
-
 struct pwm_mediatek_of_data {
 	unsigned int num_pwms;
 	bool pwm45_fixup;
@@ -139,14 +140,14 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(resolution, clk_rate);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
-	while (cnt_period > 8191) {
+	while (cnt_period > FIELD_MAX(PWMDWIDTH_PERIOD)) {
 		resolution *= 2;
 		clkdiv++;
 		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
 						   resolution);
 	}
 
-	if (clkdiv > PWM_CLK_DIV_MAX) {
+	if (clkdiv > FIELD_MAX(PWMCON_CLKDIV)) {
 		dev_err(pwmchip_parent(chip), "period of %d ns not supported\n", period_ns);
 		ret = -EINVAL;
 		goto out;
-- 
2.49.0


