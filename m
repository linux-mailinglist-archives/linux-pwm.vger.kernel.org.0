Return-Path: <linux-pwm+bounces-6693-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBB2AF59CA
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 15:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0FC77BE32F
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 13:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249A52820A7;
	Wed,  2 Jul 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoaQMvp3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA50F2798E1;
	Wed,  2 Jul 2025 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463306; cv=none; b=IMRTZLmoSEyyPhtuOtOOZAL3M33lXy2dZJxEVy2tPjUBTFqzdC3+ZqY/0uKugiehBPojRbp+HGJaiQA5x87gGX8/HuTAgzakjBasvTzajM3d6Oh1+pCZw1OCm17VmBvBd839MzwGzOvpbGqzWLyj81Nwr0Kzwo/4qQZAQnGkNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463306; c=relaxed/simple;
	bh=yz6RDNXygYPgwHueo50xYfAg5/XMtEqqHX2R9cFTQ6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Oei+lgYG0cGI650anZvstQUa3DFiRDRDuaUG3RmO280bIQgoB46hfQ6yI9sjFbUyhrZMioUGLkcfmjiGv5y8nEbse76GN2XKrGrsO/uqbduRIts/A1sx7cYrCI+cjGdt5YsEu40eKmp2AerJh3SWKlw0U5te4a4p5OGosYiWZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoaQMvp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25B2C4CEED;
	Wed,  2 Jul 2025 13:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751463305;
	bh=yz6RDNXygYPgwHueo50xYfAg5/XMtEqqHX2R9cFTQ6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YoaQMvp39A+gSprJGdfHC3QMq7z9GbpW6taK70abgXykp7MvsOl4yXrYJZsTainME
	 RGOlr7UqSiaGwyes6TZ/MdAwfKewwc5+09yw+Es6DwtyLEnW5VczLHlV+qVnh1nzbX
	 FUuQxt26oQDWKBRn+bDqLBOJI1G0lvS2d7IPAr3Ed/N96fPkSpBnK43B0EHEByct9C
	 e6YMslp0Xsz+qnhtcnM2GRGeBFJYjR4qF6SFMYmLwYUyayOP0l39WYwqNEBUdpp3Ry
	 j2Tcz6JbG2mkDPab0+rUVv4lXTnyWBDLop9SoHwMAxRCouO6uw0is7C6HCLlIWYg/z
	 v0PvRrvBlgmqA==
From: Lee Jones <lee@kernel.org>
To: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liu Ying <victor.liu@nxp.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250701-dev-adp5589-fw-v7-0-b1fcfe9e9826@analog.com>
References: <20250701-dev-adp5589-fw-v7-0-b1fcfe9e9826@analog.com>
Subject: Re: [PATCH v7 00/20] mfd: adp5585: support keymap events and drop
 legacy Input driver
Message-Id: <175146330240.2952961.9492767526035062765.b4-ty@kernel.org>
Date: Wed, 02 Jul 2025 14:35:02 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Tue, 01 Jul 2025 15:31:55 +0100, Nuno Sá wrote:
> Here it goes v7 with proper changelogs. Also took opportunity to fix
> some spelling issues brought by Uwe.
> 
> Thanks!
> - Nuno Sá
> 

Applied, thanks!

[01/20] dt-bindings: mfd: adp5585: ease on the required properties
        commit: 09d55a54b466d60a71573c78a99a901410ef73e0
[02/20] mfd: adp5585: Only add devices given in FW
        commit: 175f199085c1253d2683f583ce32b2e02cd70de1
[03/20] mfd: adp5585: Enable oscillator during probe
        commit: e551760164a74ac00916fad64ac2d0b1d3d714c5
[04/20] mfd: adp5585: Make use of MFD_CELL_NAME()
        commit: e6545bdb1b7681da7edb6a34bed4be5e7f41cf52
[05/20] dt-bindings: mfd: adp5585: document adp5589 I/O expander
        commit: e65e2b0d0f7e75c40f426e0f3e0a1bb6faff93e6
[06/20] mfd: adp5585: Refactor how regmap defaults are handled
        commit: 1a4eabf662543c62ae1e71a26d1c8e6643c66388
[07/20] mfd: adp5585: Add support for adp5589
        commit: 0190a72f28ee0995c546fd4fcf80ed25a0fc4b28
[08/20] mfd: adp5585: Add a per chip reg struture
        commit: 7077fb501b95360c7fe35553f2bdb1ccf34edd16
[09/20] gpio: adp5585: add support for the adp5589 expander
        commit: 9f425bf713b511b1078e0fea5a88c497e13dbb64
[10/20] pwm: adp5585: add support for adp5589
        commit: 75024f97e82e63d02b0743500efb1e264a1c2dd4
[11/20] dt-bindings: mfd: adp5585: add properties for input events
        commit: adf4932bc97ec9363dc5c0f8390ee5caccf0f41b
[12/20] mfd: adp5585: Add support for event handling
        commit: 47a1f759b776ec9287f675f5d4fbf60b94cc566d
[13/20] mfd: adp5585: Support reset and unlock events
        commit: 333812da70d5f71bf5e176f6d55a5f716301b5fc
[14/20] mfd: adp5585: Add support for input devices
        commit: bd113a13e1fa51789f55987369b80e1d8bc19389
[15/20] gpio: adp5585: support gpi events
        commit: 988b28a83b658137e58123f4dafc3a1588e1cb2b
[16/20] Input: adp5585: Add Analog Devices ADP5585/89 support
        commit: 19298ac01306e564b48df9aa239731cf967298d2
[17/20] Input: adp5589: remove the driver
        commit: 3bdbd0858df6574b71cacaac073f117d65a36dc6
[18/20] mfd: adp5585: Support getting vdd regulator
        commit: 4bdef655542d8ed4bf3d57ea06ff128176f4927c
[19/20] dt-bindings: mfd: adp5585: document reset gpio
        commit: ce262d6d629a926c8c9a2075af3b9a270ab6c641
[20/20] mfd: adp5585: Add support for a reset pin
        commit: 45ee66c37f9bd8cff7718c70d84e0291d385a093

--
Lee Jones [李琼斯]


