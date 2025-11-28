Return-Path: <linux-pwm+bounces-7717-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0787AC90726
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 01:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30A84350445
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 00:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856452459F3;
	Fri, 28 Nov 2025 00:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqPtUlca"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC342405EC
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764290357; cv=none; b=tAjpH7NCD1zqAlHB4IJ9oOXsC7PJMYfr3pTBN6fFrEDJCLpYlAHzBZIMVsMsLDTtKHxt6eT2hTP+c0Uej74S+8wRjvTIspsX32gQP3oGH+4FmsRY64zBAn9oVg2gXXRs7ilgRUVfrz8hLN9e9SyQdTU7OLtlGcrLWuYZk/MVs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764290357; c=relaxed/simple;
	bh=WOq1YW7wq3HS5+cHcKixizRdQWiy6j/4QvFIRjT0MJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzrzKcha9pV4wDRgzeJ4JorUlHjdKQfwNm39V5jhj0jK8jMUkR7+HhTMFLdtt3x3GaCb5a42QXel38XkmguNQBeKCuriYSVourAk9KIubPdg60OZhAgNXEjYzpzmwWJvErRcEWvah0WwxTjaCP2Aq3hVRHtipuNRFdjkImYQ3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqPtUlca; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3434700be69so1812082a91.1
        for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 16:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764290355; x=1764895155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/YQHSdmYKHhmDGGPEMrdtR1A+cTvuvC4LJ1tGjv8I8=;
        b=iqPtUlcaKRWyQRCY4+3xRuIy6eNlGmtr0dendtoMaaZyEZRiMX8nNudLFANW9M+mDT
         NbCWM3bVN+cGoqiNCUKVWZlWXYnu5wQW59/XT9MayUDeG+HX67J0mwdmvyUJrG1Tk5rY
         xFJeLYSKFXEGphvoTnwVKvLwVG832CFX5AHAe2idJWx+bZZtY7CZDWWS/41yQGxiILdL
         7Z4sD8C4Q+NbuEjqktQFIqPtYWp1kfXIVAuCE3hdO/LVD4SFhgGm6fxyHM9CSiiDO7H2
         ID5c5fEEwZE15kek/iNSKQ2FGEj9AMOc+twnJxXwjTevyxWaaoHh7IIu2CPIAoEvnz3v
         Z4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764290355; x=1764895155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J/YQHSdmYKHhmDGGPEMrdtR1A+cTvuvC4LJ1tGjv8I8=;
        b=Ub7zyv7tQtSOsHTiFYWSoBhKLDkFwkdkT4avGR+BcP1OhHxIYCvao2jD2jhn1RbXt3
         FDdqCgnlfUJYMFoNqFWKzd8fP2WcvON+NK4faCQyT2jjvjC03JWiWlyWMOp017rSi/Eq
         LpP6Cy+H+cDmJ5NBmh7fy/iKpT4RcZJJqKuZK3FgN5+hfm0w5FsOGYxpPC0gmlbDNDi2
         JNJcv/ilDkguxsnCejw9Z+KoZ3MwVQBDKphrgzYThvPCXpTVni6U8IXLvEQNKqDwvwTZ
         MPqF5XDSem+h0ORxTpXlzFdTBdfMZ2OKFxQdG0phGxRy0SyJR5+LCQFzV206ha0D8NW+
         nMgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfh8olk7ulZ1KCIL40KKmlhPqZ1vSQ5cK5em3pgSeDIogj0KskRsp6EYGUT0lGsijuJYFbCdxThbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/k/jTPPoSCVEDw6AF6R1qsqhlS9Soy9wckSfqD+pT5MnpqpBn
	k4OF7P1Gb8kA3ezywVQ3XKP/HgS4ZnADiAlRBfXcoUG6zyYksah8OhMKVs1LBg==
X-Gm-Gg: ASbGncs+UJX6mR85aW6i3FR1zCOMvzEue1U+cxIhx8OwMLfmTqgDFk0eAkP3CyboVU9
	Q8T/DCecO3X9N6KFSDh/K/Gz6DSrqw1C2ngOXcMF+/G3mLjXr267UOkNqc10pVMi+Ptwf1HDo6n
	GB+GBF/i3grFM8IBRUF3Ozz6a6IVtAJozUMiIgaeWsO8k/7nhJaSKhrtrNwWRj9brfa0+cQmp0k
	H2DNfdTCZ3djiBQqNQWbdFLDg8sbmbzGydowDYWlV2ihEG0xXhhX6Shp7osm2JI6qKKq/HZAJHa
	tgHo4+IvZVxDfoU70JbpDE9T0F88Y+IydSQDERhvOCbbEfXQHzSRze8BHPW/7q2SP0mGPfUMEEP
	G8eD8Rqm+h1dDekTRezcKX//Hy17YduhICbiFdB/OIMTjM8I5XAXKfg4WGaoZZSIrd+dnjcM3DG
	ZL99/wEBXVf2IUjuiS4bU7hTyKN/8BNXdum7O0bTPGAVs=
X-Google-Smtp-Source: AGHT+IEv4vdl9lLJTO3HqF/g7Sx2GEZeOVzwQkJqkH1dcL19xrC5/6vw7li43aKHsakF6DHQijeGhg==
X-Received: by 2002:a05:701b:2719:b0:11b:9386:7ecd with SMTP id a92af1059eb24-11cbba58da4mr7307599c88.42.1764290354895;
        Thu, 27 Nov 2025 16:39:14 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm12404561c88.4.2025.11.27.16.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:39:14 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v7 8/9] pwm: tiehrpwm: tidy period conflict check
Date: Thu, 27 Nov 2025 21:36:33 -0300
Message-ID: <20251128003634.247529-9-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
References: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tidy ehrpwm_pwm_config(): drop redundant parentheses and keep the
period conflict condition on a single line to follow kernel style.

This change addresses a style warning reported by checkpatch.pl.
No functional change intended.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 6a792faa62ce..d472d717abca 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -264,8 +264,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * same period register for multiple channels.
 	 */
 	for (i = 0; i < TIEHRPWM_NUM_PWM_CHANNEL; i++) {
-		if (pc->period_cycles[i] &&
-				(pc->period_cycles[i] != period_cycles)) {
+		if (pc->period_cycles[i] && pc->period_cycles[i] != period_cycles) {
 			/*
 			 * Allow channel to reconfigure period if no other
 			 * channels being configured.
-- 
2.43.0


