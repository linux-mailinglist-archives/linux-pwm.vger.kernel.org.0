Return-Path: <linux-pwm+bounces-5182-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC12A60C10
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 09:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09E117F1A0
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 08:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C021C8FBA;
	Fri, 14 Mar 2025 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag6lxXU+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259E19C56D;
	Fri, 14 Mar 2025 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942179; cv=none; b=lBK0JZPBMNDGxw1vbTb2aNfd9OCackCpnmTbBoQVwh9TdnX4b//Wt0srcz5z4gIm5329dNgb83xPNPxVybgf6mlBC3qGbxvm3qRxPJjfkWJolA9T5I+PlBpwVoEbWyx3yyCtk44Ek/f+LOY9pQbHOn1O9AH22sOOPmqMdRZhwt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942179; c=relaxed/simple;
	bh=0ObzWRvZw8FFO+B4zra+VkItJLzVjVZoNX85Oqlr8Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4HcDOBaAeitcuMz+F3ggwm7TbvukL8V7VQOv3Ir5vh9TIzk1H+sM+Q7TsbRVl+cM3nRn8uKJBV7GhoVH/Q6KUmXhATmKLePnEIt6N7/dvATFgPk6aKREyyC69W5dhmOImIF2HG3EbfiG7sSPgdPHDxMCnlCCfBTBYgWSSo8I0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag6lxXU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45878C4CEE3;
	Fri, 14 Mar 2025 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741942179;
	bh=0ObzWRvZw8FFO+B4zra+VkItJLzVjVZoNX85Oqlr8Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ag6lxXU+ST/72DfScUVbutcmevG+l8xy0cjiUCWX7ucTU63vsx3LQcSJ1soVSgnQc
	 pWfr1/NoTNrwwfJsKj2UHFbc6LHyodWDLgQLNYi5gg8D3pxgYxd2jB0maSSMMP9XvK
	 AZQyKvRrnbQbogqRu8jLkkvB0dE1cCtuHGv165hOVRGkasBvlB5OfLJ2aW6lxKQmGt
	 pgmT3STJsyKdza5Wa5ueiR1BFgdfWNNdcdNI9sjmmStk/UUjNLuS1gH9FOQcqeKWPZ
	 ARR6CFEcS1ThzQqnaraRmYL641iHMjad/xwg+L/QVbOiIR4yR67xI8YJs8z0bc7lll
	 yI4FWLHnLRFqg==
Date: Fri, 14 Mar 2025 09:49:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH 05/18] dt-bindings: mfd: adp5585: document adp5589 I/O
 expander
Message-ID: <20250314-outstanding-futuristic-cat-5d8240@krzk-bin>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
 <20250313-dev-adp5589-fw-v1-5-20e80d4bd4ea@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250313-dev-adp5589-fw-v1-5-20e80d4bd4ea@analog.com>

On Thu, Mar 13, 2025 at 02:19:22PM +0000, Nuno S=C3=A1 wrote:
>    reg:
>      maxItems: 1
> @@ -63,13 +70,26 @@ allOf:
>        properties:
>          gpio-reserved-ranges: false
>      else:
> -      properties:
> -        gpio-reserved-ranges:
> -          maxItems: 1
> -          items:
> +      if:

Do not nest if:then:else:if:then, it leads to code impossible to read.
Just provide if-then cases for each of your variant.




> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - adi,adp5585-00
> +                - adi,adp5585-02
> +                - adi,adp5585-03
> +                - adi,adp5585-04
> +      then:
> +        properties:
> +          gpio-reserved-ranges:
> +            maxItems: 1

one tem?

>              items:
> -              - const: 5
> -              - const: 1

But here two...

> +              items:
> +                - const: 5
> +                - const: 1

and this is confusing. I don't get what you want to express.

Best regards,
Krzysztof


