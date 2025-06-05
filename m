Return-Path: <linux-pwm+bounces-6246-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADCFACF0B4
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jun 2025 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0629188F4BB
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jun 2025 13:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D3223535B;
	Thu,  5 Jun 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPc127wW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4023FC6B
	for <linux-pwm@vger.kernel.org>; Thu,  5 Jun 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130163; cv=none; b=OVZ5Mb9WS95kTSYggpFJkWqxl26oWipe9ZzqA4nvXsjaCb0p/7pbymkpTsNtSiLKuj34RVWIpB0/2Tfpg/e2pQVoEkemDwVRXC1S+ZUe0rXO7HBu6cGqL9h58Uss3xbx3cwy3vDJi9vNEURaPEv6LaasXSOyfdWihHBgh4QruXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130163; c=relaxed/simple;
	bh=h/yqq5HFi78JCobXR8PcMZdAb80vQUDHwHsEUDOOT5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOzTLieuvjYVolC7pD5HECCTiMKL/i4Gr0a3AB5AWPjuGBIddAuRgWHvgYwLK/kLCzeityivoKnrAwIER6zQnIKVjMMT9N2VqPpZdB9nFcgAN3hp9aDdY2lWoOcURXikbnzrwL7M84yUhbAhCsy35OIR+89YohiDFpm3BRjQ6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SPc127wW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55220699ba8so1175005e87.2
        for <linux-pwm@vger.kernel.org>; Thu, 05 Jun 2025 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749130159; x=1749734959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GUAkxOIFy9jpQLSmntQ+q8BrdugRJdUj6yz2GA9p8E=;
        b=SPc127wWjSzoo9g+0BY3hlXWkSxZED10KdWyzd1889B3eZcP+B6x4C7RP7LgjVTOua
         wYuPZxHWlbt9cMcDl7cnYbaRUvVcYg5lxqjmAcEf3Ci0ih4JDhX2FPqWOJm+N9nr/aT6
         zM1nlPWXE3Bgf8GZ9lEE3xOVu1XsITl0/wjssI8hh8ePPwp8o6IkYj4vEnwwfvr5i8Im
         QVLnxAJpvnbDBmn0GCBx40KRyItWKI71jCKxKquy3jGLg9QVKBpQ0CsjIfqEQfqwZwuu
         09zJCjJWsQ1A5dkc+ECLiPuoDYBSu+TeFz9JKngucjDJaSqXaydsabkizxBFP7/xhYsY
         lW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749130159; x=1749734959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GUAkxOIFy9jpQLSmntQ+q8BrdugRJdUj6yz2GA9p8E=;
        b=FADqpQJ8DNWaDINvBy1ZxJ6mEr5pCdCUMSo9ekP+rcvUjkq2TtawJzGB2F5RVNGp3l
         15aXdhsZPXM1xZwNfpeBENwrHtbU4vmkTm2lcAYd0aSggTvMvlaCMWn7X8GCONmxE3aq
         cjXC1UKvYB44UUApcgjdxrKwbCnP0zZKGTXipo+t+oiBMi73B+Tft2cfk17Sf0DVyYz2
         7HYn1UMvhUT6dBtQSLHrnFHE+25Xq6TGGSJc2ZT/moyVhn0K1JKam1msBJKbTC8T+2Yh
         82oKau5M5bXwpJVZYDVxfiIyFL5qm2/dS4YupBlsA7tzXkAeTgjvwccR+H2FkXyCFQMP
         ssEA==
X-Forwarded-Encrypted: i=1; AJvYcCV6aVSjUUXL0XnNqHUt2iZHXQ0fE2RPpv1RLe0OIpHszyOe4wqsxUlCyUSsfQtyVidO3SUhD4ttyLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWDV8bQdstPE9har5fNrwOk7j6WCH3qtGLHPs6er+D7mqTsxp
	dv3yKbULuqlN8gWBEa3WgVAVxkWtf4j4qRezOKe5B7dLs5Ac6w7CANiYljBdqTiPtzBic2NO+eI
	CwtYKc8dw7QWLfoOn+judHX7fIkTKAc/yVA5fToIt6w==
X-Gm-Gg: ASbGnctSFWvjs7hxcvhQ1oecjUngMU9gAdvFhCCCZdEJTTMRU5n8MKiCz/7DAA4nvR7
	MvDVAJgUnfEBT8yGfb4WNy5IN7wvxOt/xeZ/qpJvBCLX4UlqYlMg7YSWxjAaNke1qHh3vQIJBsx
	F0pjwrAR89iVCuUhrlRzt1KlbKdYHQ7HPt
X-Google-Smtp-Source: AGHT+IHQ5la5bmYfspb0z+rHTezHnXmn8S0sJvRzX+sgZ7IiaN7ipgyy98pOXOBzrw28bsqpF2v0lH7bNQ0EOyTmIHU=
X-Received: by 2002:a05:6512:3ca8:b0:553:2a56:2e8d with SMTP id
 2adb3069b0e04-55356df1dd7mr2038017e87.40.1749130153902; Thu, 05 Jun 2025
 06:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com> <20250602-rk3576-pwm-v2-1-a6434b0ce60c@collabora.com>
In-Reply-To: <20250602-rk3576-pwm-v2-1-a6434b0ce60c@collabora.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Jun 2025 15:29:03 +0200
X-Gm-Features: AX0GCFv01J_2f7I-yQlAWEluILmgAXhjV0w8aFTFPw9c58Y0wmETNUPszWxuq5c
Message-ID: <CACRpkdZRjLFa3Bni=wMG1LBoWnW+Zenj2FVP=_2s+U_1eykt7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: pinctrl: rockchip: increase max
 amount of device functions
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	William Breathitt Gray <wbg@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Kever Yang <kever.yang@rock-chips.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, kernel@collabora.com, 
	Jonas Karlman <jonas@kwiboo.se>, Detlev Casanova <detlev.casanova@collabora.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 6:20=E2=80=AFPM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:

> With the introduction of the RK3576, the maximum device function ID used
> increased to 14, as anyone can easily verify for themselves with:
>
>   rg -g '*-pinctrl.dtsi' '<\d+\s+RK_P..\s+(?<func>\d+)\s.*>;$' --trim \
>   -NI -r '$func' arch/arm64/boot/dts/rockchip/ | sort -g | uniq
>
> Unfortunately, this wasn't caught by dt-validate as those pins are
> omit-if-no-ref and we had no reference to them in any tree so far.
>
> Once again kick the can down the road by increasing the limit to 14.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Is this something I can just apply?

Yours,
Linus Walleij

