Return-Path: <linux-pwm+bounces-211-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0C17FBFDE
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 18:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC464B20E78
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD2635263;
	Tue, 28 Nov 2023 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6anGXVq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40074D5D
	for <linux-pwm@vger.kernel.org>; Tue, 28 Nov 2023 09:00:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b4c2ef5cdso7739275e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 28 Nov 2023 09:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190828; x=1701795628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwvJpYryPkBoAlrqUeDyMITpj3kFJ2mze6o1YZaehoI=;
        b=R6anGXVq4yCphGsiZJBUJj37rHTWHvTX27kkw/oPXi26PhLdVWKat1u3Q6RJbLahcS
         6oA05rkpfA+1gAshbYvfnGgBBFFxhksaeL6PxoK/5d9MQat/aZoLWftXpSS1YaXu+wxq
         otdz0dfGR+E/g4JpVlDoHS9QGbM1NvkhuiIDhlG+m9AUSpm5qFV4q1CP4b0sfTCLDMwh
         wPD+DeOIIYsSReSPfGu6k6s+PxGecfgFRHTAi6WbnQd2KSFbtRi+5Nxk6T777/3sDGl6
         +Bn3NA12wXlsmTJIMNoZdeD1fyXaOgCopCB0loGxPFTndDx3r/hv8ElDSA2PWTHzwaGY
         PMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190828; x=1701795628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwvJpYryPkBoAlrqUeDyMITpj3kFJ2mze6o1YZaehoI=;
        b=bnttCor9JwB1bfYelwfFcebwRHhhUO2UvhCfdqLt2vRYufeTTPG1o2CWy/l9zXLGjy
         KsTT/E+jW+DHBdvF2+YBMLmtzXT3LuzAWhCDlit/Qtm3sbJ9N2ez6P23wuBMSq0155nA
         C2DbNs5tNuLD+l2tHTsoJsz88zEje4NJCbkFgM+wCC6H6yc5dS4NuCw026JNQNBgkoiN
         oY9IR1skugNePiP+jrnzNSkRbglMEKA8GYKGABAcwLIrgCZdn5bEmVCP0Df7b+GvAip2
         m9cAo8oTOUujbzS6QVkwqb1PBu1uLHgUubeJaPaNbYd+eEHBt94xTzhwKyxBStgujwbz
         hf2g==
X-Gm-Message-State: AOJu0YwvSOr8CtHvTaRGZOf9U9HTP/Ch5UJ5fwW+f3GJlkidM5JDcjFZ
	X6jzfP1XkLHlf7yGM8/zSs8Eaeghfpg=
X-Google-Smtp-Source: AGHT+IG1gaPfq+XWeyy6EvJWk3RQfROOtHJg5M7X8Ez9QilcIGCXhwg/8nvXmbcLBwa/UGtpJ8l3zQ==
X-Received: by 2002:a05:6000:180f:b0:332:f889:39f7 with SMTP id m15-20020a056000180f00b00332f88939f7mr7357099wrh.10.1701190828228;
        Tue, 28 Nov 2023 09:00:28 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d5443000000b003140f47224csm15520133wrv.15.2023.11.28.09.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:00:16 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 0/3] pwm: Reorganize PWM identification
Date: Tue, 28 Nov 2023 17:59:56 +0100
Message-ID: <170119076358.215216.6044730842132263589.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114112009.340168-1-u.kleine-koenig@pengutronix.de>
References: <20231114112009.340168-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 14 Nov 2023 12:20:10 +0100, Uwe Kleine-König wrote:
> all these patches were already sent before. The first in
> https://lore.kernel.org/linux-pwm/20230728145824.616687-4-u.kleine-koenig@pengutronix.de
> and the second and third in
> https://lore.kernel.org/linux-pwm/20230808165250.942396-1-u.kleine-koenig@pengutronix.de.
> The patches were last in their respective series as they had some
> preconditions. These are all included in v6.7-rc1. Also conceptually the
> patches belong together, so I created a single series from it.
> 
> [...]

Applied, thanks!

[1/3] pwm: Drop unused member "pwm" from struct pwm_device
      commit: 2fddc79446c5009dca3c29d6e784e2d05dea78f9
[2/3] pwm: Replace PWM chip unique base by unique ID
      commit: c572f3b9c8b7eb582b0ce4e2f67535ad76819361
[3/3] pwm: Mention PWM chip ID in /sys/kernel/debug/pwm
      commit: b7614b748bb35acad55050e5a91ba6284870f62f

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>

