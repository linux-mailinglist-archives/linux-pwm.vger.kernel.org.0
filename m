Return-Path: <linux-pwm+bounces-7136-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9062BB30DA7
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 06:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB9C7A50CD
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 04:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33271AB6F1;
	Fri, 22 Aug 2025 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnkKtM9l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3057B3207;
	Fri, 22 Aug 2025 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755837845; cv=none; b=RGsWRssV0WhNT3xiGyaAeQxcA0lAK0hF3nzOHBMHc6i4CRhR9bQFDhP5miLI6L1gxBwIMxnQa24qkWNyPKJv1JrtEb6gq6nqxxZBv8b00eDe0lMavJY+Pwro0F0N7n7FrGX7mkV1vykyTXSPsxntg2bRU41LSkAfk/y9cBd8Ers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755837845; c=relaxed/simple;
	bh=bBFDWPqnmliNbgpYd/Ecxh9lrCjH3iR1zG7ocsQC33A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5CnvOw6+7uIKTiKXRXtxwDEmKYtyvZok6qsPGk6iNnGijmKHI1gOBz9CHEUovwr+9NPiu6wSpIv7zfsWKCK7BqzTolpoBmw96kt6KQxfbfqPl9xdVyY90Cpex+Wm19oeg8VANbCN395GV+cYvrg3J1Ji6J4OXGKvl7OoHPWqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnkKtM9l; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24458242b33so18172045ad.3;
        Thu, 21 Aug 2025 21:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755837843; x=1756442643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJ8xmRhWvHBeY/6eJ7QFNbZvGCD85H+wlWlvcUtXk7E=;
        b=fnkKtM9lq32svoHyauwzdftHMw6FSAGIPPu9Xdyeu2m1ncjdpTZtleLsgw9Ra0arjG
         kx5/HUOHGtg2BQlHCNkHKe2ZftoZR94bJ6/wY7TnBvUqvFV1jcCpsljngBvMq4Am3iL4
         cVmP1oKGAh9UA95YJT/Yp4UFsl7Tvvz6fNEqdTwyimzCWG67/vpQpfVGSxY/o4tunYzl
         5JXkFn27rrKTCSRpfOXdIpabnaeULEfLmSvnYZt9uz+3f+gZfoRcvSmo86eH16nZFyuy
         4+ZYO/gV9pSX9BlpI9jE7jodTux8sfiNJOc9nh02dY3ae1htB9yPxougK+2rlDFkzdtB
         JYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755837843; x=1756442643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJ8xmRhWvHBeY/6eJ7QFNbZvGCD85H+wlWlvcUtXk7E=;
        b=bsXzgxBkaSo/S/+/34rk6171/jSZQIiqHWbAkQEQCT8ZKX5lhAC324YZXPWNtSG6Ov
         Zs/xKvJx5ubEJrhRvTpzPe+L8OuyiM2rk2jMktX7EGLecpKoJiKcxx0uh223InzjVCG5
         N0WLgr/6XgJ8jCSHfNNtGfoSobud8nslDVgMMw2fpTzGSgYIzw/8oGaKALGHRApcS4in
         OCmc14o+Nms5RflIaZyOKvkhddI+jWri24w6Q0ZngYVpUtkjy/WG+kTtFjeDcLl6gjKj
         a6gqaNSCyhpB7ww0Vu7hJGAsOXDQzhzzx3XuKi7sUYnvtBKJ9mJnKiiVMAXAZ0SO8kq5
         dsLw==
X-Forwarded-Encrypted: i=1; AJvYcCWGsnm3O4iF2Zs6Q/8xCtVoBzIoVo7kAPwO8YBr1zm+fnhlkewAp0QbsbLdwqNfBRsVwSrxIYQNSzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ja+2uPz7FUbrjaQc65JToyFnbiyKl2aanWNd10D/L3RoFfwJ
	maemgY/fCd2En0EHgpC2ZQ+EcfjDP7EsEH24b+mG6D//zZjVPPZoC92P
X-Gm-Gg: ASbGncs98/5Wg64+3ytgEGewJfM0C/SfVDAoZGrCsruRiheaakQrEj6/NJlKt+Eka86
	Vm/HP7ssi/WYxWNPQEA96sSJR/Gv092P6vaYJ4odQTphUxcTqlisryyjwrS9Ed73mbTTrJJXzwW
	58Jh+xmxiD8Mxw0T15jt3vVu5blI9bIBxhHwrxAbvyrGCdDmYURrXLAHlZuvYxzaAvW8WS7ucuE
	q6hjHbbk911fb9KeTFMPLodsF0jPuhTsBkVQ8vQH9igPsS2fJDsLxJi8ekNz8+or1DFarsF8xVl
	cdQp7d3iGXwhqvfwjjJsYL7OY96ptXM2BG+2+TiPL0xiSQYLRIg9gUPZJTjEYhMnCwQ3p2A/0rT
	aZocRSXe1CknxlOH+u+LlYjPhIjoECqMUcvGveATbs2mcJlY=
X-Google-Smtp-Source: AGHT+IGRj9Ccg19k4Bwyhj4OpEoF+6whrC1KfFkJO3Kv9AK4y1/ToXYp0Yl9gDK9sSjH4KnpHgEQrg==
X-Received: by 2002:a17:903:24f:b0:242:9bc6:6bc0 with SMTP id d9443c01a7336-2462ef8e7c5mr20101545ad.55.1755837843324;
        Thu, 21 Aug 2025 21:44:03 -0700 (PDT)
Received: from paradiselost.local (lohr.com.br. [187.58.145.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24629bb5f5csm14392925ad.130.2025.08.21.21.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:44:03 -0700 (PDT)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v5 2/6] pwm: tiehrpwm: use FIELD_PREP()/FIELD_GET() for prescalers
Date: Fri, 22 Aug 2025 01:43:08 -0300
Message-ID: <20250822044308.4052-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822044024.4015-1-rafael.v.volkmer@gmail.com>
References: <20250822044024.4015-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual CLKDIV/HSPCLKDIV handling with GENMASK() and
FIELD_PREP()/FIELD_GET(). Introduce TBCTL_PRESCALE_MASK to update both
fields in a single ehrpwm_modify() call, and drop the unused SHIFT
macros.

This improves readability and lowers chances of off-by-shift errors.

No functional change intended.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 8509dd587..d140814a1 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -25,7 +25,9 @@
 #define TBCTL_PRDLD_SHDW	FIELD_PREP(TBCTL_PRDLD_MASK, 0)
 #define TBCTL_PRDLD_IMDT	FIELD_PREP(TBCTL_PRDLD_MASK, 1)
 
-#define TBCTL_CLKDIV_MASK	GENMASK(12, 7)
+#define TBCTL_CLKDIV_MASK	GENMASK(12, 10)
+#define TBCTL_HSPCLKDIV_MASK	GENMASK(9, 7)
+#define TBCTL_PRESCALE_MASK	(TBCTL_CLKDIV_MASK | TBCTL_HSPCLKDIV_MASK)
 
 #define TBCTL_CTRMODE_MASK	GENMASK(1, 0)
 #define TBCTL_CTRMODE_UP	FIELD_PREP(TBCTL_CTRMODE_MASK, 0)
@@ -33,9 +35,6 @@
 #define TBCTL_CTRMODE_UPDOWN	FIELD_PREP(TBCTL_CTRMODE_MASK, 2)
 #define TBCTL_CTRMODE_FREEZE	FIELD_PREP(TBCTL_CTRMODE_MASK, 3)
 
-#define TBCTL_HSPCLKDIV_SHIFT	7
-#define TBCTL_CLKDIV_SHIFT	10
-
 #define CLKDIV_MAX		7
 #define HSPCLKDIV_MAX		7
 #define PERIOD_MAX		0xFFFF
@@ -173,8 +172,8 @@ static int set_prescale_div(unsigned long rqst_prescaler, u16 *prescale_div,
 			*prescale_div = (1 << clkdiv) *
 					(hspclkdiv ? (hspclkdiv * 2) : 1);
 			if (*prescale_div > rqst_prescaler) {
-				*tb_clk_div = (clkdiv << TBCTL_CLKDIV_SHIFT) |
-					(hspclkdiv << TBCTL_HSPCLKDIV_SHIFT);
+				*tb_clk_div = FIELD_PREP(TBCTL_CLKDIV_MASK, clkdiv) |
+					FIELD_PREP(TBCTL_HSPCLKDIV_MASK, hspclkdiv);
 				return 0;
 			}
 		}
@@ -280,7 +279,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	/* Update clock prescaler values */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
+	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_PRESCALE_MASK, tb_divval);
 
 	/* Update period & duty cycle with presacler division */
 	period_cycles = period_cycles / ps_divval;
-- 
2.43.0


