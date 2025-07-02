Return-Path: <linux-pwm+bounces-6692-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F765AF597C
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 15:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E17188DA93
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E66280A52;
	Wed,  2 Jul 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB1ln7zV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8D27C854;
	Wed,  2 Jul 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463302; cv=none; b=Z/W7yAfIDgu5USECDr6fFmuNyzhH0KXt5vj5SplVQTAXhpLfPYOfK0tqhCUeOG/LEoyRM/WUQIrxzBzOm2RUge7J3rb99se9+oqxNi6jl0B+MNBvyd2+hhXbKZw5vvEmBHCExlDBdAYuJvYQhci9W1Ke3cEl/VHsHKraPLUet7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463302; c=relaxed/simple;
	bh=S4iC7GGQaysX341VMGTZmw2RFWVwRqvN8ZBILpJhitU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qscq9+rsucAUaDKpo3R37bCfX4mbeKw1q/RiYJtnqB0xi4Wzmuz6B26DnVVVdZxZgebkUwN9Q+OVPfWFNsEJhxfh4SSIv946Wz9Hpm7kjnwsGopPxulmWkG/iyQQ0iBklRAYeYRXjVaYD3Mp61TLSJipWZVTsQ9v73s4GHxLEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB1ln7zV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0398EC4CEF1;
	Wed,  2 Jul 2025 13:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751463302;
	bh=S4iC7GGQaysX341VMGTZmw2RFWVwRqvN8ZBILpJhitU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MB1ln7zVsP6AlY43HZoG0ncfxo28nAUNgRIVwkvnPzmXSelf5PfKDBSpxHoi5VkXW
	 Lf3n/gaRnpBMh6mLM1jdxtQImvwzUABcl0lZEpqk2G8yjwclQT5G7EkXNFOV0wre85
	 yVDA7l0EhDBllmPcZAYTJpybIAgyGIXrNVM1MegKdZ1Q73tE2YEot7390y4R46s8yP
	 YegaESvVlC7SXglXbdW1++UiiSBWbn5OJOqUQNjuX3wNuRarw9oIo8g/BaimufvDom
	 8auWsxy9DO0CXAp2Jj0Fi3NmJFLp0GqOELUKuI74U/kK+ntdoo4HalHbFDiDKcXcyH
	 gLbY4vz/z25PA==
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
In-Reply-To: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
Subject: Re: [PATCH v3 00/22] mfd: adp5585: support keymap events and drop
 legacy Input driver
Message-Id: <175146329875.2952961.4372083276863600634.b4-ty@kernel.org>
Date: Wed, 02 Jul 2025 14:34:58 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Mon, 12 May 2025 13:38:52 +0100, Nuno Sá wrote:
> Here it goes v3. There was some major refactoring in this version due to
> Lee's and Laurent's feedback. There are some splits (and some explicit
> requests) resulting in new patches being added. The biggest change is the
> effort in trying to minimize the usage of specific child device bits in
> the top level device (mainly stuff related to the keymap). I think now
> it's fairly self contained and the only thing that we really need to
> handle in the top device are the unlock and reset events as those can be
> supported through both the input and gpio devices (via gpio_keys). This
> results in a bit of more runtime complexity but well, that's life...
> 
> [...]

Applied, thanks!

[01/22] dt-bindings: mfd: adp5585: ease on the required properties
        commit: 09d55a54b466d60a71573c78a99a901410ef73e0
[02/22] mfd: adp5585: only add devices given in FW
        (no commit info)
[03/22] mfd: adp5585: enable oscilator during probe
        (no commit info)
[04/22] pwm: adp5585: don't control OSC_EN in the pwm driver
        (no commit info)
[05/22] mfd: adp5585: make use of MFD_CELL_NAME()
        (no commit info)
[06/22] dt-bindings: mfd: adp5585: document adp5589 I/O expander
        commit: e65e2b0d0f7e75c40f426e0f3e0a1bb6faff93e6
[07/22] mfd: adp5585: refactor how regmap defaults are handled
        (no commit info)
[08/22] mfd: adp5585: add support for adp5589
        (no commit info)
[09/22] mfd: adp5585: add a per chip reg struture
        (no commit info)
[10/22] gpio: adp5585: add support for the adp5589 expander
        commit: 9f425bf713b511b1078e0fea5a88c497e13dbb64
[11/22] pwm: adp5585: add support for adp5589
        commit: 75024f97e82e63d02b0743500efb1e264a1c2dd4
[12/22] dt-bindings: mfd: adp5585: add properties for input events
        commit: adf4932bc97ec9363dc5c0f8390ee5caccf0f41b
[13/22] mfd: adp5585: add support for event handling
        (no commit info)
[14/22] mfd: adp5585: support reset and unlock events
        (no commit info)
[15/22] mfd: adp5585: add support for input devices
        (no commit info)
[16/22] gpio: adp5585: support gpi events
        commit: 988b28a83b658137e58123f4dafc3a1588e1cb2b
[17/22] Input: adp5585: Add Analog Devices ADP5585/89 support
        commit: 19298ac01306e564b48df9aa239731cf967298d2
[18/22] Input: adp5589: remove the driver
        commit: 3bdbd0858df6574b71cacaac073f117d65a36dc6
[19/22] mfd: adp5585: support getting vdd regulator
        (no commit info)
[20/22] dt-bindings: mfd: adp5585: document reset gpio
        commit: ce262d6d629a926c8c9a2075af3b9a270ab6c641
[21/22] mfd: adp5585: add support for a reset pin
        (no commit info)
[22/22] pwm: adp5585: make sure to include mod_devicetable.h
        (no commit info)

--
Lee Jones [李琼斯]


