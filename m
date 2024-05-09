Return-Path: <linux-pwm+bounces-2166-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6E98C1099
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2024 15:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3311C20978
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2024 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44246158D98;
	Thu,  9 May 2024 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcGiqcaZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA01586E7;
	Thu,  9 May 2024 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262390; cv=none; b=MvT7jRAZQDTSsTfpDaypWd8G2ZAbEHAt08eYcod/bEzxZAgxf89Of1BahDRNHKrn5NZQrh2+zyElmQQpUXjZkWX6eauCI+YdCgerliC3ByUv72E6+8RkhCiUE5sgYToOnp5LTXT7mXX6TCCZislYNjm8qeX6IytESBcRmH6Esi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262390; c=relaxed/simple;
	bh=05v+AZCi8SL4RKzjToP1WNbFIlRrJj5S7b7mtFwLo3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3/WIYgdJCQ2+H0lnLSB6VVrEfmq7Uw9a29DjfZuBkGbD0/B2qlltX7Y2xX99wX5HRG2JVMeJIMyUkoRMq/Pa6K9BgoDx9r37XfB9EoRZyQ0beEBWwpQXxejLr9aV8FB9fNGn1kNrRYnb9U8163stNInY1Uo2oST5DmpQi+/mi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcGiqcaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B81BC32782;
	Thu,  9 May 2024 13:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715262389;
	bh=05v+AZCi8SL4RKzjToP1WNbFIlRrJj5S7b7mtFwLo3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DcGiqcaZ+stZzuErLPwy+S/9TXxZUmtBalKZxYobOs8jd+tB6A+qwd5wFzFUKmFIj
	 tcE0NMw3JVpQMR1X4cprjwacxvzqI3DUxN1kBEu6r5UqFyzmW5OaZR6ufOXea9z8nM
	 7qOrhe+yl+VSRNrFT2ce1ymiVqqKH0SyBUlbWF/zrdE64SHVWYhEstjUKoWd/+nrJq
	 jSlXIEIaP7sx6pF3Ppa64+maQLYe6hbQpM5lJDP3DEcyX7HR1fuYURxXR/rDxSnFHn
	 BAJg5Ari6+nVH0YTj8KZCQYhCSYxDCTPigp07psJQvczYIgQiOg2mKa1mhUaRQv8n+
	 9SoVYvi8yqB2g==
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc236729a2bso916763276.0;
        Thu, 09 May 2024 06:46:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjiE/OAjfFGTQ03i922AeHY7EWPYLyNr9l2bwgos6Bu/XNwjFXcrxmWt92rAPAqBWQPn1VRoCf+HnYmm0ZFExORuwRt0C92VB019y1VSfGe/UXWwGwlYN8ltKMF2+LSKwEFJAfiw==
X-Gm-Message-State: AOJu0Yx2hSd2GP2i4cvIh/XX3zZErwYW9A2yvsNpj8m+FaKPcTjqmprI
	asrR5RyHiyELcLmgyoa8n4lVtRNbbb2N66nZ3LogRPpyi6pvgQhCRSGOV5e1rSxjDYAYUD7h+R8
	hUaGXN5kVFZv79AbIFVcQf0bE2g==
X-Google-Smtp-Source: AGHT+IEvyYTnwYJyzqg1ZOCg3stwZjT/mqB7lBJXlxymWAC8lzRWPjxmQ3TJLCUtoXxgx0DZrkt6DxSejhK9KvzEVWg=
X-Received: by 2002:a5b:3c6:0:b0:de5:5040:ea12 with SMTP id
 3f1490d57ef6-debb9db1f9cmr5973046276.32.1715262388785; Thu, 09 May 2024
 06:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0590d8898e553f29c96c7c4083f7b3ca1915727.1715050962.git.zhoubinbin@loongson.cn>
In-Reply-To: <c0590d8898e553f29c96c7c4083f7b3ca1915727.1715050962.git.zhoubinbin@loongson.cn>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 9 May 2024 08:46:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJewzGp5E+O44JgvHu9Q-3PKaXnhjUQbmV7OHfFCEX3Ug@mail.gmail.com>
Message-ID: <CAL_JsqJewzGp5E+O44JgvHu9Q-3PKaXnhjUQbmV7OHfFCEX3Ug@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: renesas,tpu: Do not require pwm-cells twice
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongson-kernel@lists.loongnix.cn, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 1:54=E2=80=AFAM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> pwm-cells property is already required by pwm.yaml schema.

This should be dropped or reverted.

> Suggested-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>
> This is a missing patch to cleanup the required pwm-cells attribute twice=
[1].
> Thanks to Uwe for the heads up.
> [1]:https://lore.kernel.org/linux-pwm/cover.1714450308.git.zhoubinbin@loo=
ngson.cn/
>
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b=
/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> index a3e52b22dd18..4c8ce7a26d13 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> @@ -16,7 +16,6 @@ select:
>          const: renesas,tpu
>    required:
>      - compatible
> -    - '#pwm-cells'

This line is not requiring #pwm-cells, but rather only applying the
schema when #pwm-cells is present. It is needed because there's also
renesas,tpu in bindings/timer/renesas,tpu.yaml. Without this,
linux-next now has these warnings:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/timer/renesas=
,tpu.example.dtb:
tpu@ffffe0: compatible:0: 'renesas,tpu' is not one of
['renesas,tpu-r8a73a4', 'renesas,tpu-r8a7740', 'renesas,tpu-r8a7742',
'renesas,tpu-r8a7743', 'renesas,tpu-r8a7744', 'renesas,tpu-r8a7745',
'renesas,tpu-r8a7790', 'renesas,tpu-r8a7791', 'renesas,tpu-r8a7792',
'renesas,tpu-r8a7793', 'renesas,tpu-r8a7794', 'renesas,tpu-r8a7795',
'renesas,tpu-r8a7796', 'renesas,tpu-r8a77961', 'renesas,tpu-r8a77965',
'renesas,tpu-r8a77970', 'renesas,tpu-r8a77980',
'renesas,tpu-r8a779a0', 'renesas,tpu-r8a779g0']
        from schema $id: http://devicetree.org/schemas/pwm/renesas,tpu-pwm.=
yaml#
/builds/robherring/linux-dt/Documentation/devicetree/bindings/timer/renesas=
,tpu.example.dtb:
tpu@ffffe0: compatible: ['renesas,tpu'] is too short
        from schema $id: http://devicetree.org/schemas/pwm/renesas,tpu-pwm.=
yaml#
/builds/robherring/linux-dt/Documentation/devicetree/bindings/timer/renesas=
,tpu.example.dtb:
tpu@ffffe0: reg: [[16777184, 16], [16777200, 12]] is too long
        from schema $id: http://devicetree.org/schemas/pwm/renesas,tpu-pwm.=
yaml#
/builds/robherring/linux-dt/Documentation/devicetree/bindings/timer/renesas=
,tpu.example.dtb:
tpu@ffffe0: 'power-domains' is a required property
        from schema $id: http://devicetree.org/schemas/pwm/renesas,tpu-pwm.=
yaml#
/builds/robherring/linux-dt/Documentation/devicetree/bindings/timer/renesas=
,tpu.example.dtb:
tpu@ffffe0: $nodename:0: 'tpu@ffffe0' does not match
'^pwm(@.*|-([0-9]|[1-9][0-9]+))?$'
        from schema $id: http://devicetree.org/schemas/pwm/renesas,tpu-pwm.=
yaml#
/builds/robherring/linux-dt/Documentation/devicetree/bindings/timer/renesas=
,tpu.example.dtb:
tpu@ffffe0: '#pwm-cells' is a required property
        from schema $id: http://devicetree.org/schemas/pwm/renesas,tpu-pwm.=
yaml#
/builds/robherring/linux-dt/Documentation/devicetree/bindings/timer/renesas=
,tpu.example.dtb:
tpu@ffffe0: 'resets' is a required property
        from schema $id: http://devicetree.org/schemas/pwm/renesas,tpu-pwm.=
yaml#
/builds/robherring/linux-dt/Documentation/devicetree/bindings/timer/renesas=
,tpu.example.dtb:
tpu@ffffe0: 'clock-names' does not match any of the regexes:
'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/pwm/renesas,tpu-pwm.=
yaml#


Rob

