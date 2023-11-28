Return-Path: <linux-pwm+bounces-219-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE4C7FC094
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 18:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2898B1C20C0D
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 17:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B37939AEB;
	Tue, 28 Nov 2023 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZadS3zD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9979610A
	for <linux-pwm@vger.kernel.org>; Tue, 28 Nov 2023 09:49:37 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bbc36f767so1277167e87.1
        for <linux-pwm@vger.kernel.org>; Tue, 28 Nov 2023 09:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701193776; x=1701798576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIAezfU5V4i15X+137zRs84aJguIecETApsweAHYW1A=;
        b=SZadS3zDLrfGoOKbmCFMeyBV0ztVPX2290BDskqw9maxilDBRiVkYkFRybdnsJoYAX
         jSFZokaUKxxK59ZdMZ/ToU7m9EUQ5HdSKxldf9EJ6abkBojM/OTdmxsqPdVo/clXn9f1
         726BPscPxXm5Gv6rdC1E7elgXUhA3XzzZDHX/h4/udnboYucO5jHefi9JvCnc3PdJuip
         V7WxdPssuslPnfs6m+k97I6rGa6R7d/reNrAa8RiOc1ROZJAdG+Y8UN35kzGAcWFqn3U
         eLMtonOFka1Ex/pyD2L7WwdsqqhpL4zTzlWZUIaqmUATUNg/4msg3nz5TsiswJxF+viQ
         uqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701193776; x=1701798576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIAezfU5V4i15X+137zRs84aJguIecETApsweAHYW1A=;
        b=qgcNLjf6r2bjq1L0cy4QLhhVvidn801sE0UCTHWZdV1LxLuT/LGgZzZi3LhF4Ikp0G
         6/bfnY9tcRzOiIuyyfaNolj7DyW96ywfjn5YLneXvmKVyliHdBIDhsdB/9fcBR7zERXJ
         WhNyabosALjAYrAcoa6+uPYo/izYiP5SMsaNL4sSDnCeSbMUyUucZ4BJv5iEl/PJ4ZMq
         Gxf6tF4PEhVd5RUjWkFKD8mXCWPkKjrYYnoWZQSBh6lwUfLegZ1eb0XxgWy6/7bqKQq7
         mT/SPyiMkQngqAUiJ0r3/GK6SLYfAUDehrAOoaEHAwZTgf/OGg1smahtzPE8hfu+giC4
         b1SQ==
X-Gm-Message-State: AOJu0YyvjNmKLHy+V1o2Rz6/jEsZ1OlSVGZMiisilinwID1p9MQqN7Vh
	iSWtqIIEY+trBFgcAttXnh0=
X-Google-Smtp-Source: AGHT+IGLx/ajG7Ro6+7rSHhh7RvluDw3EeEXY0NVHO2nCh63CWI85nTxBO+CeSFb9SEEBbxEeZUTXA==
X-Received: by 2002:a05:6512:3d8a:b0:50a:756d:40fd with SMTP id k10-20020a0565123d8a00b0050a756d40fdmr13593292lfv.11.1701193775613;
        Tue, 28 Nov 2023 09:49:35 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id lw5-20020a170906bcc500b00a13f7286209sm971010ejb.8.2023.11.28.09.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:49:34 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 0/5] pwm: stm32: Cleanups, get_state() and proper hw take over
Date: Tue, 28 Nov 2023 18:49:25 +0100
Message-ID: <170119374433.445690.3475637524078126762.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
References: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 19 Oct 2023 22:06:59 +0200, Uwe Kleine-König wrote:
> some time ago Philipp already sent an implementation of .get_state() for
> the stm32 PWM driver. He created this series from the feedback but
> didn't come around to send it out. The goal of this series is to allow
> to take over a pwm-backlight from the bootloader without flickering on
> an stm32mp157 based machine.
> 
> The only thing I did here to Philipp's series was to split one of the
> patches in two. Philipp had the contents of patches 4 and 5 in a single
> patch.
> 
> [...]

Applied, thanks!

[1/5] pwm: stm32: Replace write_ccrx with regmap_write
      commit: f98ef6bec483b921ae4341c7719c2fe26d5dd6ee
[2/5] pwm: stm32: Make ch parameter unsigned
      commit: 4cf03120c3a96e89ef2ec28f752e47d11be6b036
[3/5] pwm: stm32: Use hweight32 in stm32_pwm_detect_channels
      commit: 406a2ae953352d88f24ca1d564c898f4d896faf0
[4/5] pwm: stm32: Implement .get_state()
      commit: 6912b67c655f502df2d3c80002562fac87801ada
[5/5] pwm: stm32: Fix enable count for clk in .probe()
      commit: c0031cba442cc13bef2385e53c29a98308a20961

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>

