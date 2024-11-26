Return-Path: <linux-pwm+bounces-4149-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D49D9ED6
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Nov 2024 22:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902FBB26D78
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Nov 2024 21:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4101DF274;
	Tue, 26 Nov 2024 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U28rJGjd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943DF1BBBC9;
	Tue, 26 Nov 2024 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656318; cv=none; b=JITbQV/nuCym5iINQboUVDzpoZSf279rlXJEt4WkWfL42ONK/siux95Kv7UnWs/YT6bsZdoQ7yD+Ti+E4K3F5AMe7NksGz3u1EjvDw1wZiWRWm1ukWLLFGv9J7R+RRlWhGtDDdAkbYG5LV3GlzZ3txmiRyPzm57wn8du314T2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656318; c=relaxed/simple;
	bh=xjS1sv7ZycCWokpZNmVAJ4ZyUQYgz7W7vOLsr0yLyTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FNEfC0nTXc7wFw+BeIzMLgdDyLn0xmLRtG4qNvLe3IaRafeiqnfVowxxetWQusiqCSCB7JN6qJqR0C95u7HF874JchG6jcb3NFhpDguBWNDrPnR27gAy0jonrE0cZpAy9g31v5Gmt2Ad4btTyhV0DsrNLLTzHIbe0E8nBbGFy8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U28rJGjd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-211fb27cc6bso60274695ad.0;
        Tue, 26 Nov 2024 13:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732656316; x=1733261116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N2TKsl83AnwP2PjSI65VRG64wOcj8ly05hFtripK2Pw=;
        b=U28rJGjdLS2KLybAYRGXgzL/hG3PIhSNd/mWD+fstTHvtCdJcSiuZdGFf0ngA/4wcK
         hloxYE5aZbXKVt7BzkjGR+maF5amA4W3DeqYVIokMFPxSSqgqMLosM5lHjbE6d2qWZSj
         xSXqX2Dxg7rOvQGQFkYBu4IYtH5FLWEpQasueGJXQWRuMQ2GlQ9CPytFiF1ukWD1X8o2
         LjoPAJE2M4XBB5DPyF3r3aXlSLYeDuYFXyj5/AtlFbSlbBa+iTe4O45kfcMR0iUY21Pz
         F5uDcqTnzg6jTbaBNV9fQJ4yPU1OAwMVEC4ipyjd2oMFXy1OG7iknbqz+nIFYp12tVxv
         QQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656316; x=1733261116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2TKsl83AnwP2PjSI65VRG64wOcj8ly05hFtripK2Pw=;
        b=v3bH60wSL2silyC3KNEd7CJ7g2+St4jliYz6QlW42lFgagbWnRbBJc4ryHEMq0MAfo
         6/ATm3QPzvVd8C5juWD+7p/57Yt++c4xWef+8ioNgK3sVq8WejLonH8Ms4pWZDsGGFJo
         mCW3kmcxc8VPUSXmXuZbQeNMFIoGxglf/6lqtj/oupUGvkLYK4xNfx9S8V9P10JnXedc
         Vf7SQgcpmMh1ieQdF4GecJxgZmnztB7tbunjvXXyic8kO9S+G0LAM2TLNvebOY9baTDD
         GpOxGtOo6PcbAlv8JYMuqwh9dKp+NZYOfEpSCnJr7Uzay81lWbnBj4KjED0AIplgb8MI
         Ykmg==
X-Forwarded-Encrypted: i=1; AJvYcCUlRTaphSc3vjbfUiWwESSLqvw/poXyU2vupnXpkSw7ZGxjOOkHgnQCGkjqg8D35Dj2OUAn4uePGlYv4K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHGzpAVIrn1pXzeIzwNR1RzOSbbahrchot5O3eLW3kZ4ALGhBf
	epzlxATomsNFOS3ybghCaGeedvdBt2EAa86bPavN36r8m44kNjo8
X-Gm-Gg: ASbGncvHPjz8f6J/FmheuUllzeN+PzrgxO+FE8iXs8O/np1xhI7xW5uEpTsDm6GZ3YX
	IFkcQVWpoqU43GnHeVH5so86zZ+l3w5atrU8UXmmpUepcJh2QiH1Qp5oGDfemWeoa6QIUYa2OLC
	F7uXZxAiDXedqe4vmBxCzu0X9gvTZ8OcQF5VwmV3z6X3ShXv6VszuQQ1XLbZGXirQh/znNE3aK8
	ajuc9fpFK0tryIAIhMAH3b/K8hTdUhjnb0T2ImlxZ265JG9MyvOjjnWvw5K9Fi7R8WUBSOTbDEh
X-Google-Smtp-Source: AGHT+IFiE6mBthTh6/Xk493ZDQ+wpHrF+Kc29cYBJgz9mge4KCwyWFynJxSWYy/r1lnU6AgvZTV/yg==
X-Received: by 2002:a17:902:ea0e:b0:20b:4f95:932d with SMTP id d9443c01a7336-2150108ca34mr8490985ad.3.1732656315856;
        Tue, 26 Nov 2024 13:25:15 -0800 (PST)
Received: from localhost.localdomain ([177.174.195.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8ca1csm89431075ad.20.2024.11.26.13.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 13:25:15 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Subject: [PATCH 2/2] pwm: correct pwm->state.enabled handling to allow fops control
Date: Tue, 26 Nov 2024 18:24:14 -0300
Message-Id: <20241126212414.15165-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure pwm->state.enabled is consistently updated during enable and
disable operations in ehrpwm_pwm_apply() to resolve this issue.

Previously, when attempting to interact with the ti PWM driver through
fops, the pwm->state.enabled field was not updated correctly after
applying enable or disable. This led to a state mismatch where the
driver's state detection logic prevented disabling the PWM through
fops once it had been activated.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 0125e73b98df..9f939d535440 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -420,6 +420,7 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!state->enabled) {
 		if (enabled)
 			ehrpwm_pwm_disable(chip, pwm);
+			pwm->state.enabled = false;
 		return 0;
 	}
 
@@ -429,6 +430,7 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (!enabled)
 		err = ehrpwm_pwm_enable(chip, pwm);
+		pwm->state.enabled = true;
 
 	return err;
 }
-- 
2.25.1


