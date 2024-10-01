Return-Path: <linux-pwm+bounces-3411-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A098B79A
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 10:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1411C20EC9
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EF5192B79;
	Tue,  1 Oct 2024 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ikMntrsJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF8618D65A
	for <linux-pwm@vger.kernel.org>; Tue,  1 Oct 2024 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772718; cv=none; b=Xec1aE7CBagUCGY8TtgkZIZSISC8Bku3eETVj9TWiw5FdzlOIkiLwn6sxRM5Lsiv0lL9RY7IXuaeW8+9AAzZQz+ccw10JMw72/IwYIv/9mK+zIbKsjMlQ4oSkUR+hpeLkIIQAaqADepV/ICjWTMgOY//Q9hcXL/2dMoIKxxYokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772718; c=relaxed/simple;
	bh=XiC0WaOaM6T5Znq7dSjw/KYFFh3KSrjRg4oppGPLg9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cqAoMkxkT13yzUBpok6ud9IN1IuQXToMeN6ycFVWCwNk4S/6ERSyErxnP5S9UrLn7XpTULYMN+/YDT2cB0PgA5LebyE13GhteWFQDavzNpr8QiQ3fg5Q05cIaTmddcl6rea1hhCfqOEli8p3ZWDHobMTEbwF90MxxzPPk7TFf58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ikMntrsJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cce5b140bso3421162f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 01 Oct 2024 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727772713; x=1728377513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jh2jPm3HuIf7/5F02JQukdzJX5ZHJz4fMoaJMaKDI4k=;
        b=ikMntrsJOa7YJNG9NWrSQVIETlCrXIi4LObaMXkVYsWL7cT2fhYKlZFSBRFSHdUYw8
         lMcREx/FPkfl6ksOEjDvpkQ1Cy/JvR/E/jETgQOVymt0W+59O/KbphNBeag6mSwVBUGD
         gcKWzPT5f3mSwAsNDVYSkhjD9ZzFevM+jSF3RGIobYVj4QC9Cwwk+GwXxLUTUOo2H1n3
         Hhy+61tBND6MDaiKvqf3aW/yXL1cKoj7C3dGeWpTW3qemr9bNQELsHeMCTVEeiExv5v2
         7E44z9+Rq53MsBA9gwNC4wp0cQHv9R1dcq/WV2qJtIlh6mePSY+0XmftFjQB9ug3fJkd
         xJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727772713; x=1728377513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jh2jPm3HuIf7/5F02JQukdzJX5ZHJz4fMoaJMaKDI4k=;
        b=Gm3AD3QrWteKiaZbMop69yvIUqjrINQpmEWbnBiENPZtU+kl+BDSPnH7uKplSiN8bg
         PitOWYLLBSu650SWa2CWhrnTabUltj14CGoP+4VP9xBBxD+B2TRmNgO3Mc3IcgDScIR/
         j+jUg2OBU1MZEE4z100OH4H1NbETJxmRrTPoP2lF6f8XW9+c8l/inPtx92UcCcf9gIqp
         vAjN4MfVitr8siwTRCdmhwS+cLXr3lmu3HYdGH1oU75S0QderRw4PiKscwfXgg8335lW
         yTE2wOgmylrP0Z2cbI9GSBaq198F4dRmTOkpY/NRjootXDXrO7doOX6/O4f7VKoOT7jx
         16BA==
X-Gm-Message-State: AOJu0YyzV3bqfJpTLWuaUWosfPvKbZCTsZwW8QrJoX4qBdChLfJXl8r8
	WmbtF7B0vxCq1CTQN/5CHM84yIrv6WLro9tlZSyvJ33IrWULNVExTO9ME9vhygmkgTWQjeoFhE8
	C
X-Google-Smtp-Source: AGHT+IE3MLve9wgVH8hoIsw5p2HNTIC90PrCYe7VoVUxThQlSDFbVUkB8DsfGU1wpAI7l2SC+juFpg==
X-Received: by 2002:a5d:678b:0:b0:371:8cc1:2024 with SMTP id ffacd0b85a97d-37cd59decefmr9934714f8f.0.1727772713257;
        Tue, 01 Oct 2024 01:51:53 -0700 (PDT)
Received: from localhost (p200300f65f01db004d6a46a6454a1385.dip0.t-ipconnect.de. [2003:f6:5f01:db00:4d6a:46a6:454a:1385])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d42esm11338433f8f.14.2024.10.01.01.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:51:52 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] pwm: Add kernel doc for members added to pwm_ops recently
Date: Tue,  1 Oct 2024 10:51:39 +0200
Message-ID: <20241001085138.1025818-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=XiC0WaOaM6T5Znq7dSjw/KYFFh3KSrjRg4oppGPLg9E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm+7gaZSlEf0YTZH5squMWiPe1cYndDvLKVXUg6 LjXTIBxh/6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZvu4GgAKCRCPgPtYfRL+ TkLPB/0XNeSYLVG54pvapPOQO86xrK3HdbXiPJhUz3yxxPizehxIjcHu6RG6tql+EmCTqVZ94ta vlwUL80osc5M4G6/CAO9qQDDAsdzTXfoua7/bnB+RvzWn+Ud4qxg3HfLKLxu7eza4ojbhcpQ+13 TH5BBnkD6XqMkzuP0P83DDbSJyuTmA14Ez5lhOOoV906VaguNfTKJmUEVrRL5QeUhQoZA4zt2bp BuJj3WDrBPzmZqVOeQaipuNOTfRCaumzweonN8ExLUhRKbIuXlrVG9y3AxPbg5qDJ7UbpD2S58D 57+qR69ty+tedT4SUkS+4XJ460FC90UGFlDjvXbHtTN7sSvb
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The callbacks for lowlevel pwm drivers were expanded to handle the new
waveform abstraction. When doing that I missed to expand the kernel doc
description. This is catched up here.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/linux-next/20241001135207.125ca7af@canb.auug.org.au
Fixes: 17e40c25158f ("pwm: New abstraction for PWM waveforms")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 include/linux/pwm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index c3d9ddeafa65..f1cb1e5b0a36 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -276,6 +276,11 @@ struct pwm_capture {
  * @request: optional hook for requesting a PWM
  * @free: optional hook for freeing a PWM
  * @capture: capture and report PWM signal
+ * @sizeof_wfhw: size (in bytes) of driver specific waveform presentation
+ * @round_waveform_tohw: convert a struct pwm_waveform to driver specific presentation
+ * @round_waveform_fromhw: convert a driver specific waveform presentation to struct pwm_waveform
+ * @read_waveform: read driver specific waveform presentation from hardware
+ * @write_waveform: write driver specific waveform presentation to hardware
  * @apply: atomically apply a new PWM config
  * @get_state: get the current PWM state.
  */

base-commit: 65406de2b0d059d44472ad6f3f88a9b4a9894833
-- 
2.45.2


