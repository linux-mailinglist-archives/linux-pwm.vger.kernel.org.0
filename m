Return-Path: <linux-pwm+bounces-3849-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 393FE9AF828
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 05:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DC31F22813
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 03:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F518BC1A;
	Fri, 25 Oct 2024 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf/AP2XF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D29218B484;
	Fri, 25 Oct 2024 03:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729826946; cv=none; b=nE6zWnPwiuLdG+t1i+6S12b5kNUJKsqrspMyMUOz3CI7AZzYj02oYSzEvvoBrCj0FE2HRwKt/tVLOf2JFSIm0crj+cAJbiPOxY9Xh+sEa9Ve4lR5Iz25/vEKw8WyJg8htuHkYTwJVuTOKTykfZS17j4/vGwvTmlmyWDYHJ0Lr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729826946; c=relaxed/simple;
	bh=bobtTiUOgm0R+YdKnDpz3RtCLS65JG7Ia6zVQHBpZy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckrotT6gn5XaU3I5yZYv4vylguxQwcFKHobSKjR3PqZvib16HBlu8Uo5O8d+HcJbSqyU606pDBQuQHJVaCVwGZX/u9VFPM3II/CdLsJE2QqHS5nyR1WynQ6Wx+fieQFJji9kxXlKjviucC9PAMyW0bxwHh0aY5ngQ24VKbuFcz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf/AP2XF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so1218721a91.1;
        Thu, 24 Oct 2024 20:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729826944; x=1730431744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl03rwfXTghu5TO4DIsVs3ACSusq5Si6Ig0V2GjyFFw=;
        b=Qf/AP2XFk7STV1HH6FE8jWtd/tetzXZqZYJenKxSL/OtjozVmJsD1+0c55WBwUaXDR
         Bb/DRTjdE6Otz3gyjyOWpHNzhL1B1m2ZhNuAXCFVyzMWA+JcXvF0As0qiCBQnjsBZvWt
         xqYlmcF+pKXQ+LX3HbKX23tTCt9sX0Ad+682HXwMUoOHay1CL/3i+HxsT80kF5bqNW0b
         FaIxgCtMXWVY77l+WY5j0moHJFGDb6pOCb65R53ttvR2tozvcAWNoAIu/pWhVFpjQgax
         6Lwy//UoP9ATaR6ucJvHRHy46uokOI6L+awDiDHAsY9x+kvoqsQWYui/eVhmAFdQTjK9
         Tcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729826944; x=1730431744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sl03rwfXTghu5TO4DIsVs3ACSusq5Si6Ig0V2GjyFFw=;
        b=TDX958WPdR344X/UGNWCb6SP0nexFnnGxi4XxLIQGQY9zASwLT+MRYjxDzIh/k8g41
         3CwwjZRn5bN3ItPHt4UQfLRQ+H8DccHzYIQQBSrbLeEakWXuhEhVYoPhnNtm8Fmz91cz
         03ua7NREoN+YBNTleUsCjHfFmTUv3eRrkO9L+DCZnLkRlB5hdJtyO8LClhKHufAz0nyu
         kMAzwvFPXicshP297EkxNh3h82tWSRn1EGwmP1LdFGOAv/W9IWW/V3OT5AZGQnzcsLhM
         OodfR8xnJCn00YtIRxMgYN51vJ7lPGzrcGCja9IsaLq7FWHMliR3PsL1OYLzoccZf/0S
         rWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIFgUVfTsr26Xk3Mk/v0E+Sz9DkGuZCXtoYDuxxQxGxT8onaIC26Z6HwTWNMSgOoOJ6Rad4O/LX+Ep@vger.kernel.org, AJvYcCWY6SVFMU5xyTHf1w0QdnEjJ6vsmyer+RuRSue0GUPSdKmMu19QXl0HumkHScLzp4sIGdVf860TR80EqCXN@vger.kernel.org, AJvYcCWrYBiFuX5XztcUKyCvxuvRhpFiZ5gPdIHPmT9DLchhLNCnxkdherdVgRj8jnkxiahPOIPWyL3Q8xJ4@vger.kernel.org
X-Gm-Message-State: AOJu0Yybfdw0po1SGehGE0vKlk34fJEIJtUNonYsnpakx+vEF+Vv+u+d
	WsoDGQ/m3S+SFNChvmJNsrbbSXjIqwezItjSHbGc8y/FNmeR9hN4
X-Google-Smtp-Source: AGHT+IGisdWRfEyvyGXXRh7g5blq5MkQ0Xl2pOeYb3wvbIHUDx4j/4H0wcRJTEQHYF63X2oR5HNGMQ==
X-Received: by 2002:a17:90b:1047:b0:2e2:af52:a7b7 with SMTP id 98e67ed59e1d1-2e76b7116d7mr8890347a91.34.1729826943738;
        Thu, 24 Oct 2024 20:29:03 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e51539dsm2308811a91.29.2024.10.24.20.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:29:03 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:28:41 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicornxw@gmail.com>, ukleinek@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, unicorn_wang@outlook.com, 
	inochiama@outlook.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, chao.wei@sophgo.com, 
	haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: sophgo: add PWM controller for
 SG2042
Message-ID: <2mwkqy7xqj6bydwutwjmyeq4swnqfmljr45rl474uqciglmpt4@2kgwci2oxyp2>
References: <cover.1729037302.git.unicorn_wang@outlook.com>
 <fec7163144d7f7b615695b5fd22a182ed7f1e7e9.1729037302.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fec7163144d7f7b615695b5fd22a182ed7f1e7e9.1729037302.git.unicorn_wang@outlook.com>

On Wed, Oct 16, 2024 at 08:19:22AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Sophgo SG2042 contains a PWM controller, which has 4 channels and
> can generate PWM waveforms output.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pwm/sophgo,sg2042-pwm.yaml       | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> new file mode 100644
> index 000000000000..fe89719ed9dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/sophgo,sg2042-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 PWM controller
> +
> +maintainers:
> +  - Chen Wang <unicorn_wang@outlook.com>
> +
> +description:
> +  This controller contains 4 channels which can generate PWM waveforms.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2042-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +
> +  "#pwm-cells":
> +    const: 2
> +

Does this ip need a reset? I see a RST_PWM in the reset bindings.
If so, please add reset support for the whole patch.

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pwm@7f006000 {
> +        compatible = "sophgo,sg2042-pwm";
> +        reg = <0x7f006000 0x1000>;
> +        #pwm-cells = <2>;
> +        clocks = <&clock 67>;
> +        clock-names = "apb";
> +    };
> -- 
> 2.34.1
> 

