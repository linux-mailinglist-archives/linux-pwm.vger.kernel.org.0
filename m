Return-Path: <linux-pwm+bounces-216-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856087FC086
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 18:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FF71C20C82
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 17:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A73A39AE7;
	Tue, 28 Nov 2023 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geWxiC9x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C20B4;
	Tue, 28 Nov 2023 09:49:32 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9e1021dbd28so783093666b.3;
        Tue, 28 Nov 2023 09:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701193770; x=1701798570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYAdPXYjdtJoSjhwdnkJc5M1Ql6U3jFAivs3ToBpO7o=;
        b=geWxiC9xIbMsM6p30SwbUXcsxQNYa3QbEBydxeuRnPy1O3LJzo/+5yDQm3g7yBCKlM
         ySCkbFNvJzsd8ik+Oe7EgIP9NBzpIkzl/4bm3ccix8oe3Rmbl58h7wad54UWbQERwMRx
         +lZdH4+1cQ2YSkR1WYskYUVkUqvjTt1vTkcUXubEsoZh6QOuC1wrWl6VxArLz2NUaPA/
         +2uWZkexO/YVWXgjas/NhXf3l5S1ls204G6MQTFY5IAE1JAr05i1fC388veD/DCXlVcE
         fUTzDCzrWLH4d3N0u4yrlCE9gEH8zCoQkOO0JfDBclIdDf1njw2ChnuYO7qM2MUg92q9
         HynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701193770; x=1701798570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYAdPXYjdtJoSjhwdnkJc5M1Ql6U3jFAivs3ToBpO7o=;
        b=ph/dNyozTXql2XUwHWwtZPG5Wh1lV1u8SxCbszzh/MRm6f6sjzeTTVyAtkWdO6ajKn
         s9b29/Hoq46LjcbF2vPi1FahUHEnhs2UnAGW3N+sRL9XXk0145msAGfNMPawyRJT8FBF
         XP80uRGgsWrGFXFVNLA96O1V59eis9YkeX1nmWpTpEFc3JbeM0DElti/Qb50eE1Aa7J3
         UMMlel1ao/RNHSYPTBqYZ9TjFoCttZ7vZap1CuzaOeHQv65AynX1Eoelh/XWElFGMc43
         nRGxnFZCV//nsum5TDGOG/FWzBYXZtHy/sdL+CzSJfnPjAdPvl99GwIDGG7mvg1ZtE+f
         XFzQ==
X-Gm-Message-State: AOJu0YzRQ2P7WN9a5xMifPJXE2zHxMrw93uk4nRk0FaLxIbfzcFwKq4v
	2HqndQu9m/HKPZF3Iki8dwoA6wlZqaA=
X-Google-Smtp-Source: AGHT+IE0MVWhM0Bx9N8hq2qRd878OFql+KxCK2r0PUI37wCSSMvW1rr+kvejleXHjv0eakxQYRO0UQ==
X-Received: by 2002:a17:906:5352:b0:a0d:d73d:1542 with SMTP id j18-20020a170906535200b00a0dd73d1542mr5581642ejo.20.1701193770276;
        Tue, 28 Nov 2023 09:49:30 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id lv23-20020a170906bc9700b009f28db2b702sm6981520ejb.209.2023.11.28.09.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:49:29 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: bcm2835: Fix NPD in suspend/resume
Date: Tue, 28 Nov 2023 18:49:22 +0100
Message-ID: <170119374441.445690.2721498852495955001.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231113164632.2439400-1-florian.fainelli@broadcom.com>
References: <20231113164632.2439400-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 13 Nov 2023 08:46:32 -0800, Florian Fainelli wrote:
> When 119a508c4dc9 ("pwm: bcm2835: Add support for suspend/resume") was
> sent out on October 11th,, there was still a call to
> platform_set_drvdata() which would ensure that the driver private data
> structure could be used in bcm2835_pwm_{suspend,resume}.
> 
> A cleanup now merged as commit commit 2ce7b7f6704c ("pwm: bcm2835:
> Simplify using devm functions") removed that call which would now cause
> a NPD in bcm2835_pwm_{suspend,resume} as a consequence.
> 
> [...]

Applied, thanks!

[1/1] pwm: bcm2835: Fix NPD in suspend/resume
      commit: fba7e9f839d7fcb0888094697da45c5668226455

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>

