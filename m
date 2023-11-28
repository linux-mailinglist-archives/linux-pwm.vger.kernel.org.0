Return-Path: <linux-pwm+bounces-215-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD0A7FBFE8
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 18:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AA01F20EEA
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 17:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1687853817;
	Tue, 28 Nov 2023 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4XoPCIL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A64D4B;
	Tue, 28 Nov 2023 09:01:59 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9b8aa4fc7so7149451fa.1;
        Tue, 28 Nov 2023 09:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190917; x=1701795717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGsTE+h92DnXeyvQhi72RUIHAES9rx7gcu8lPhY952A=;
        b=V4XoPCILo16DifF0q/6hGt1IlsKIH+4sMW+XVz6g5P6VzyASpCA1ZXqxDDRclp3zsT
         yP8EAjEoqejPh3dVTdJWwPsmev99kGtBTQjdAjzlUGS/qDKe8fJmqX0ZQoLZCMVkAUlN
         Bn+pPt3Kf07RAROPZjY1cbP+7cEve5NTp6lv4UVeFA0DalF8rqWZoReInjFi/lE7FDal
         HB4G8sop2HCfJVIGAg7Ssj4rwpNK2aAeVWZv1Bz6VENsdcAvV6zabV2PrDJXChVZ6qAI
         WNx3Mi1sItgh08NLufd08wA1Dkz3LPdbpkiuIfaaYy8bZZiLG0hy/s8/Okwr9swLHFJ+
         Il0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190917; x=1701795717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGsTE+h92DnXeyvQhi72RUIHAES9rx7gcu8lPhY952A=;
        b=XepOclek2Yw/iufF9ohDYB86m9l5I2OoaipJDLNYfr48Ts0RRIsNtGoCXPhZf4GnGd
         RdJsvcWgDfFIQRCah3gSI04A2m6wGwRmZHAeo1n1+wKGkfTWrO2qCrrubt5jyGDwHQrx
         MH1axJ5sAQf50OOhPFwVbWOQxS23OyR7G3QLCRzCZrIJ5Da/lWQfsRzT087GpT2egtOw
         b0ismAxvS3HB4NGuq+Dy+ww5P2kd4+4KpExZDc1ReK0OmN1q0INv3F4gnRrcH5DYyQgQ
         xFwcuY26VCR9ZGsZ7T+vpZqp5sfUI4WI0zj8Bl8dImP2uYR2jMcORZJuRJAbMI+ZY547
         v2xQ==
X-Gm-Message-State: AOJu0YwcJua1OtteWbfilgCxE187Lq5xkzRKlrIzj/AW+FgW808Xnm6W
	xK84hfDSpmPekc4I4Ewzztw=
X-Google-Smtp-Source: AGHT+IFAuEe6MZgvA+lTavbcl8TE8o7Pzs/YhJ/lRM8NRtuzYKZoNxgz0oR4YOKKydd71HKVsz64Jg==
X-Received: by 2002:a2e:a58d:0:b0:2c9:99ca:1317 with SMTP id m13-20020a2ea58d000000b002c999ca1317mr6615762ljp.24.1701190917070;
        Tue, 28 Nov 2023 09:01:57 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id fa8-20020a05600c518800b0040b478da760sm6785928wmb.48.2023.11.28.09.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:01:56 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 00/11] pwm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date: Tue, 28 Nov 2023 18:00:00 +0100
Message-ID: <170119076367.215216.2570140207863942749.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
References: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 23 Oct 2023 19:46:17 +0200, Uwe Kleine-König wrote:
> this v3 was necessary because some lines in the commit log of a subset
> of these patches were eaten. I think that happend during rebase -i where
> git drops lines starting with # during git-commit. git-am isn't affected by
> this "feature", so application should work fine. Still checking these
> lines make it into the git commit is a good idea I think.
> 
> Other than the few additional lines in the commit logs, one Reviewed-by:
> is added and the series is otherwise unchanged.
> 
> [...]

Applied, thanks!

[01/11] pwm: atmel-hlcdc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
        commit: 68bb27818889b085d3d700be69c483c0ea98f433
[02/11] pwm: atmel-tcb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
        commit: 440e46389dda0aafdfade7fabfa5038f9544ada2
[03/11] pwm: berlin: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
        commit: c462d3f8fd2fc80aa7430fa7a498cbc92f65c3b5
[04/11] pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
        commit: 96f68f6f4932d6ade6878f13c1f644f6b469cf6c
[05/11] pwm: dwc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
        commit: 9109a4a23509b1664e6479aaa7fd5e983f8387e1
[06/11] pwm: imx-tpm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
        commit: a5b73204fd2e6a78a29cc4baea071ef715731ddc
[07/11] pwm: samsung: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
        commit: 1b12fa3894ea89fefe057f128a5fddc71e3e693c
[08/11] pwm: stm32-lp: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
        commit: a692911fca53e41fdf5c8bc5d66f00e96511762b
[09/11] pwm: stm32: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
        commit: 7c885017ea5b0e8008b18ee175f2c4d0664a4ca1
[10/11] pwm: tiecap: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
        commit: 3ecab1549fe44b25f58fb32eeaea152062513894
[11/11] pwm: tiehrpwm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
        commit: b372157f23ea8aa99a240c47a7ba1268656554d5

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>

