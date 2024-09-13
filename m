Return-Path: <linux-pwm+bounces-3263-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D297883E
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 20:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC621C21C2C
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 18:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07739139579;
	Fri, 13 Sep 2024 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHKns8Jb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD93032A;
	Fri, 13 Sep 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253797; cv=none; b=qD3Rd+cb3emr7UR+st4bjQ2I2WMtkI1rG+JXq4sJGxskaQVqtRyyF45lf8s3r1RgRf87oCMY8DZ0N1CHfdTbayBDPbdBysckt5yeC/8PlH1nXGsaSmtjOKwNciIX9ft7UcijroZnTg4g8i20Ts6GyJr0v9YJDKcv/1X5phHlYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253797; c=relaxed/simple;
	bh=Qt3WqlAXhsTUdih86ZFXxBiSxdezTR3T196e9DV/Wm4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=kk7cCOrcWVbabceUw4I6ucLKNrqJXCJOkEgd13eaTzv/VsN/Uocv+nkwbd9PZZqH/r3/6OkhRsWUyO8nIaxpnp7EmfvQN2IeLjyozBJGCB4XjeskGtztBq2Vhkc/jXnjj7r4tR3ZQg2oz50UwZ9tB9Z+fbWdKYTVxOvY5S9r6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHKns8Jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9A2C4CEC0;
	Fri, 13 Sep 2024 18:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726253797;
	bh=Qt3WqlAXhsTUdih86ZFXxBiSxdezTR3T196e9DV/Wm4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gHKns8JbosAIuTvrSqxeK2aq6CJw+YKHLSJAw8ToPw0RI5oeXhWx01XrVWHNuHV0/
	 qZ1ruZGOhb3RTM1oZItA8CK03eHeb3qZqdyA7V/ljn0FmyNICrxUUvk4sA46JJctWF
	 nccYiWeJi177FfcEbuNJN7UmtvuTsThUuhb/qOBEFZu0CXHd60jDAsJLvBQdb/iq8C
	 KRNtyEUvMmmA8z5F2Kto23wXj0wYCScwM2n+YeSl14xWfifuqrdrSP02yk/4kzO5/g
	 wKqFf27d+SLaHTkGv8hmhBVVP+SQUBeXN/6RZBW0ONInU5z6nUm+Nyp17l3VMSZw0U
	 XyAc4ofiJw3UQ==
Message-ID: <eced45837d63618e5383f5324adfc5c3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-2-2d2efd5c5877@gmail.com>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com> <20240913-starqltechn_integration_upstream-v4-2-2d2efd5c5877@gmail.com>
Subject: Re: [PATCH v4 02/27] clk: qcom: clk-rcg2: name refactoring
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Sebastian Reichel <sre@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, cros-qcom-dts-wat
 chers@chromium.org
Date: Fri, 13 Sep 2024 11:56:34 -0700
User-Agent: alot/0.10

Quoting Dzmitry Sankouski (2024-09-13 08:07:45)
> clk-rcg2.c uses 2 variable names for pre divisor register value:
> pre_div and hid_div.
>=20
> Replace hid_div with pre_div. Update calc_rate docs to reflect, that
> pre_div is not pure divisor, but a register value, and requires conversio=
n.
>=20
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

Nak

hid stands for "half-integer divider" from what I recall. Feel free to
document that, but don't rename it.

