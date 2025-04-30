Return-Path: <linux-pwm+bounces-5778-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D999AA47BF
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 11:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B1D9C09FD
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 09:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE123537B;
	Wed, 30 Apr 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M/U96/Vp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86EA21325D
	for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007099; cv=none; b=ZDoHou9zeo94lce2FrtZX4ajSsc4732iryeJpKUZjtRD8EI9EAF5oHtKABBU2c/mskzN0ZdkM7vn9vH0VY8/6wO8VA8qZAR1fIvSEgRpb5Qd4BbVEO0iw8feNz1SLXp2UWL7No5OG7/WjKfCJB5CLCV8ly2ZVfNYn/APcsZQHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007099; c=relaxed/simple;
	bh=Ux1lSv/ODoHafw8NN4kfW3nJGFslo2MuBF/+Iyljx2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PEHRu9lAn48bl8b5rJPEoS/a2O+OFnvYpb6x5m+Fv8SGARadXWAEGilqrrY/lvydrGbH9oaZu9x41kB3NLaZ8M80k6oAVx7OvxePXqNbr5mtn7V0dQIm6DUFJtNCSwwCUj4iZj4nODmfrgrQ2OXL5lgabtiaF7zMh0RwtuwOAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M/U96/Vp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso4661341f8f.0
        for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 02:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746007095; x=1746611895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ojVPFPoj72cbDrEfzyh1SLYL+3XLD89PajzAoaTffVY=;
        b=M/U96/VpMsE9q/Tp8CfwFq648hCFV89J+VLVjX78hLJNDgDc6qtuWXDWcfPcAQ11nM
         rbESy59k19GlKliweQEpRbEdoxxpbJMgY50vGPtxEhbOeJtBn9g1ZAdSoEqcmvSlauT8
         iTAbwh5k/j1EjeS8H22HRfkuzl2qUMwW7/hFe6g8UgyJeB44BNa5XJQjuBGk5MYKla3g
         Xt9/3Qkiu8vFlO0eeoxrctChhG+8IBNUPcZbxR5dMz07XVNYvriCA+dyQ3W33JOipdAQ
         6P5Wwp1v91uem7yd0K6SLhNynWZ8sN+rb/H5WOfKhhctDwV+1BeUNVCnzu0VligumkvU
         74iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746007095; x=1746611895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojVPFPoj72cbDrEfzyh1SLYL+3XLD89PajzAoaTffVY=;
        b=I5Tv2Grg4VnejmuTKO9hA2DDvRFxPRjyB8BkLWAP/co0a9D287eehhru5yHV6bM1V0
         nPMNDh11MDxuXwonlk3xt9ulAlgYAc/V1EsG4tooxtc4gBh7ZchM4nfzxuvfiUa8xlq3
         zuw+/ZcwkalpjiVF7H/iRULz5sFUDTWUDi1LuXSaLglvYnne1mTyQovM2a8wG5fNAlTT
         kY+dv5Gd/XT2grxGtHmSh/AzCZDaS2U9UvdVOhaYrOJGB23MqzeQX0YLb47AAHdj/AFZ
         Fya6p4rd9GmpNU/hJ6CvKMdMrF5OdjNfe4EVZ0mKUC2T0i4Mcu56ed0zv3nvlXG2Ot97
         eKUA==
X-Forwarded-Encrypted: i=1; AJvYcCVeQljvNRubnrxapywW1N602hSYW1CkJtzBOuFO7n1BuiVuFKvBiL6eHM7LL5Yw7EEvbRnQQYTB/h0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywliq+XpRvtn1W2ZyG3F+KrufEI1CCebQC6+q1qWLX5JNPupKou
	UtNJ1j8Qxaly8WVTrAwEwHDzFwOO1gbdgS3ZTf3OALOQrFyCLUyPvmq97Lif3tw=
X-Gm-Gg: ASbGncssiaBJlWx23B3crTIuS1S61Fk2Pvc2QnEBDTMRir3LFX2wc/K/vkeqlEXPRPa
	VWn7DSpoV9LRPDMKWFTUXcZ8s38TmZh14Dl3CmTIz6RMsthMb4h1aI0oJ55WoZeVfElXPFbAyyA
	xA5yvI3T0p8FOTQwYtuI5TnvLHLYO2ZYQTHiTlWqdh/syGXEsbb0VxdqSMEkTt0mm12jQaEP7+/
	hsBYEtmhfki5rE535+kXfJFrriVH9xqCazUbkvODBfHd8GOt1HDLP6fKsAXqQpgZ6REV3wRzqxo
	zBD3EWHtHzBgBurLVL0dxlG8Cy6EMEU7zWrTnuiyQX+yZb9qlY2n5O3p1o18dSqM8ghCdXX3vF4
	d+sCLB/w=
X-Google-Smtp-Source: AGHT+IGuK4ubxajjdMneL07piaB1dzdp7uaqBR3+WB6iRtOElTvsGegjGX3KJyxnCXSFeCq6+g1zZQ==
X-Received: by 2002:a05:6000:3109:b0:3a0:82e7:227a with SMTP id ffacd0b85a97d-3a08ff34d04mr1592154f8f.6.1746007095050;
        Wed, 30 Apr 2025 02:58:15 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073ca4cbcsm16280871f8f.25.2025.04.30.02.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:58:14 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 0/4] clk: pwm: A few improvements
Date: Wed, 30 Apr 2025 11:57:45 +0200
Message-ID: <cover.1746006578.git.ukleinek@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=690; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Ux1lSv/ODoHafw8NN4kfW3nJGFslo2MuBF/+Iyljx2M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoEfQa0Nbntd8NTipaTkM6DAnir5IUAf0Z9kn/9 M3h7PRdb6CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaBH0GgAKCRCPgPtYfRL+ TuE3B/9GVnay9UfLoo3ODdXCDg5PXDMoBdE4nEeIqGywmw9aOqSdDF/c/8mWH+C23uN1MuiPAuj CVUpTkiurUu8Xxr/GF6mF2YkW0ujNSIuNfYnLa/YWw0kL57/9r4K8zwwMcf3ZKQCdhX2Lo7Am4Q RFLrXT4igb8u9pjg8WdvnTAkL7hy6cZD73x/U/NQ86m2dpqcYlWMXtKk0Jm8VfKfnE18kjkYPta 0dxGbybDV5r0DukXpC6pXvdsD655PBokt9g6byEzdL8dZ+fFRhcEx/kj1St5GtJVF2swhCx0BZQ a1DDiojcfum+svv/ckzlt6J2lVoo38MsH8nHaiuPta2hMCCP
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

my main objective here to get rid of the call to pwm_config() as I want
to drop that function. While implementing that I found a few changes
left and right of it that I think improve the driver.

Only compile tested.

Best regards
Uwe

Uwe Kleine-König (4):
  clk: pwm: Let .get_duty_cycle() return the real duty cycle
  clk: pwm: Convert to use pwm_apply_might_sleep()
  clk: pwm: Don't reconfigure running PWM at probe time
  clk: pwm: Make use of non-sleeping PWMs

 drivers/clk/clk-pwm.c | 49 +++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 11 deletions(-)

base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
-- 
2.47.2

