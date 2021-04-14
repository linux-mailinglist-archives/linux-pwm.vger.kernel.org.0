Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5546F35FA7E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Apr 2021 20:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352688AbhDNSNQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Apr 2021 14:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352624AbhDNSMz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Apr 2021 14:12:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A70BC06138D
        for <linux-pwm@vger.kernel.org>; Wed, 14 Apr 2021 11:12:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s15so24840385edd.4
        for <linux-pwm@vger.kernel.org>; Wed, 14 Apr 2021 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8cMsDT9er0yB1vAcvjl5ixcilD8+YkGrcYft26XCmo=;
        b=Dc2TJ4cZEHs6KJ9s7IOUBRa+KjVExnbDv1YoO7FzRj9z13fDkJV+xCLxVlVj5n6v5j
         GW2wnsJkg/I/FlLkrT+L3/IUlb5HE4qUCnnnlgfpvELIUdeeMkZZNTL4hIfjQ5AyJXXO
         0nh7D60iJ0cdMjTLbX6O3a5uyksmhyzwbKhawkON3NmVl/VtrdFGS8oJwKUlbmGR23rJ
         Q2D3aaHDnzF0nuh5n3RWyp9KbGA00hUwLb/W5ZpGUUphHQZO5f6HrDSXM2+27GZcZfPa
         /xqgppvcS7w28CB2Jb/b93+pgiuVgv3jgnY54w6uIGZCvm4te19r3gkXiuzsJsiXKsKz
         543Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8cMsDT9er0yB1vAcvjl5ixcilD8+YkGrcYft26XCmo=;
        b=pTIqYVv0kf41bS05jlOyeAecWPoDsM3gR1YYpGh/wiJfbl7t1hZG7/zlumk1I0Pua5
         sHM4vRfVvialvQOft64ZHZwPXafw3tyK02FIc0C5j7KfcKBSLXq3dwyF/QaCDxA0aeB1
         13rzMvnp15rDvXU5nQrt07KZHlvOg4U33S4ToqlQGwq0HyGWpcI3rnHHWWh6y9lZugCU
         +/gLH40G+242ePB1ON3jMgyCkH4R2jMhv4fXuZohGnBynM+c3UsbEDyplXzDTRgSo4jL
         3fHppAH7RCsnn0eaKkMMDRqCXYxzSkY3lUL9XXRdO4RqOA39Q/TYcxtp5EYkklG00VoA
         mQPw==
X-Gm-Message-State: AOAM532u1Nbowjp94xc8kgWiog8Z6pihUBsDhbFLmw/+rCx1WfJ3NI76
        lSFwq47scN5NgsajkRjq50XVfTLFK59dVA==
X-Google-Smtp-Source: ABdhPJy07wiGwp3wa0/ZBXYc7WlybCUgXXjfZ8f/v2CdjW/WEP/SDmpS96vAcpkD3zT1dlobX688sg==
X-Received: by 2002:a50:e702:: with SMTP id a2mr183896edn.3.1618423952806;
        Wed, 14 Apr 2021 11:12:32 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "David A. Schleef" <ds@schleef.org>,
        Mori Hess <fmhess@users.sourceforge.net>,
        Truxton Fulton <trux@truxton.com>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: [PATCH 55/57] staging: comedi: drivers: ni_mio_common: Move 'range_ni_E_ao_ext' to where it is used
Date:   Wed, 14 Apr 2021 19:11:27 +0100
Message-Id: <20210414181129.1628598-56-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

... and mark it as __maybe_unused since not all users of the
header file reference it.

Fixes the following W=1 kernel build warning(s):

 drivers/staging/comedi/drivers/ni_mio_common.c:163:35: warning: ‘range_ni_E_ao_ext’ defined but not used [-Wunused-const-variable=]

Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: "David A. Schleef" <ds@schleef.org>
Cc: Mori Hess <fmhess@users.sourceforge.net>
Cc: Truxton Fulton <trux@truxton.com>
Cc: linux-staging@lists.linux.dev
Cc: linux-pwm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/comedi/drivers/ni_mio_common.c | 9 ---------
 drivers/staging/comedi/drivers/ni_stc.h        | 9 ++++++++-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/comedi/drivers/ni_mio_common.c b/drivers/staging/comedi/drivers/ni_mio_common.c
index 4f80a4991f953..37615b4e2c10d 100644
--- a/drivers/staging/comedi/drivers/ni_mio_common.c
+++ b/drivers/staging/comedi/drivers/ni_mio_common.c
@@ -160,15 +160,6 @@ static const struct comedi_lrange range_ni_M_ai_628x = {
 	}
 };
 
-static const struct comedi_lrange range_ni_E_ao_ext = {
-	4, {
-		BIP_RANGE(10),
-		UNI_RANGE(10),
-		RANGE_ext(-1, 1),
-		RANGE_ext(0, 1)
-	}
-};
-
 static const struct comedi_lrange *const ni_range_lkup[] = {
 	[ai_gain_16] = &range_ni_E_ai,
 	[ai_gain_8] = &range_ni_E_ai_limited,
diff --git a/drivers/staging/comedi/drivers/ni_stc.h b/drivers/staging/comedi/drivers/ni_stc.h
index fbc0b753a0f59..0822e65f709dd 100644
--- a/drivers/staging/comedi/drivers/ni_stc.h
+++ b/drivers/staging/comedi/drivers/ni_stc.h
@@ -1137,6 +1137,13 @@ struct ni_private {
 	u8 rgout0_usage;
 };
 
-static const struct comedi_lrange range_ni_E_ao_ext;
+static const struct comedi_lrange __maybe_unused range_ni_E_ao_ext = {
+	4, {
+		BIP_RANGE(10),
+		UNI_RANGE(10),
+		RANGE_ext(-1, 1),
+		RANGE_ext(0, 1)
+	}
+};
 
 #endif /* _COMEDI_NI_STC_H */
-- 
2.27.0

