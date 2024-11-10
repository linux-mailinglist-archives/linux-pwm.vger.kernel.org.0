Return-Path: <linux-pwm+bounces-4054-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F749C31C1
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Nov 2024 12:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA42B20DA1
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Nov 2024 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A87D1537C3;
	Sun, 10 Nov 2024 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfrZefiI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F176013D600;
	Sun, 10 Nov 2024 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731237404; cv=none; b=pJoJv+c8KJFwDfnY9oWneGMv3qLkzEE232PYPlj4uBefhJx/MZVkzTGETsgHKgv/mRQvWkOD+A8e2SNOEd4Tggpy3I7ATd7Ud4VzgAbJlhbCiQMWoelcyoTJ+kaC4bsuc1RRPxQRG4aINJ2/XicqVvymlRksxVZyde91/TTFa2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731237404; c=relaxed/simple;
	bh=OZq9vlY9kg8nMFQ9iEn/BhUcSlMehFtK5IV3YHw9HC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4xSEAntPQn/Ss2He0bHQ+V8IgDUtzzaNX+YY2yozVzpaXeEmCmJHTwvNBPrUKZvDr5Jj29R1oxsZYPrUu0xYZQMIRvBni9/fKWgPfMKRqX78E+sL+CEIK9NqAFEeXQZ/eAHDVpp3S7oHCjsr0j2rcYkfDrx1nBopmGiiEHnuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfrZefiI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso2908566a91.3;
        Sun, 10 Nov 2024 03:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731237402; x=1731842202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWLoy1wYXdVgZ3Zzo/mgTNAnxY3fZNEXmyBhaGh3Xds=;
        b=TfrZefiIi93OLr6+GdwWL27ufVOSjanvpwlvUHt54VRTme63C5cAfMryP73beXumHX
         UPUFTj3qeQKgg9QZgHi/ssmmMBWLJP67BbcHy6qIjHGPMxKcQwiZuViye9vRRUQi4IDj
         fHACmMOLu5DJSO0hXFbSBAakaj9uCiPuBRkvWCM0oMW5DwzQyYqOgxQM1EAjrZDWZVyu
         J54XnqTcWUh1uc56s1NYISH6wIscWX8OlomAsOpmj4RLfVg+ggOvlW2uh0rZrfBWUbUT
         xBBQxKT7Pf9ZciAHyp/IJkfXlTIE9pHyVxYvVpA9O2peCHIWEoMKRClRhrsl5rL6kOWY
         k8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731237402; x=1731842202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWLoy1wYXdVgZ3Zzo/mgTNAnxY3fZNEXmyBhaGh3Xds=;
        b=OSpGUtRrF9wFBNNNOFTHs2FXXSGkE9Q4PY97Pg4bhPwkqF+5autCVZTfeUlNHEhCgb
         CItc66BNL52G2NKJFzrbKtHqUDvSUcUmukj/u+Bhk5epnChMpXLdsY844743x6IKbi7S
         13Fihi9nR7w+kJu6U+xnjiezNtjFKHoPnAfdNdZsvQLKLDSi6yLNdxrpC7KxaZldrUOX
         p0GX/jknhHW3R8Rf6BnahvbGb3QyJkDqkAIfBs8gWCh2fFx6F0i3UpmPyNL+eL3zuJAt
         ESN/qbG6I4DrMHeDNSOkyr9/FfN5KdLKnzpMA+NyE9fJES5JiMFxHEt82Te2EO7vpIAD
         3/cA==
X-Forwarded-Encrypted: i=1; AJvYcCWZrRrhujFlNAplAKjlLfz4dHcZGll/rsmt57zWXo2vYOCzQqKXTykCrXKHv2tyg+iR2GOjC5c2jKaC@vger.kernel.org, AJvYcCXMDcpHjIdRoeYsbegEhN5Kk34oAHuEVGLd6vNFNp9VGZ8D/YBr3XNX6RDP6bvSaWVneUGahOlzJb7V@vger.kernel.org, AJvYcCXmoeYfQhTxjPuiCVSbdoIC5rtmdW4y4gtljRBbxaSCZj03nVTjcK6CFKxp6oKhfjzWLI+j0XxPGAEdOaGT@vger.kernel.org
X-Gm-Message-State: AOJu0YxLeq69xN4HeWH2nTvDe5LKgai3VcKazklwcvwIqzWq1K05OKW9
	MGQ1PFCY3OrF3qtYel1vCBc3Cudc9nre/hZr6JDaCPsq4je8EY3bZbGiXab7L2qjr7PdqugH8oR
	hXBXAm5MEDYI2iwck3dCHiHnm7g==
X-Google-Smtp-Source: AGHT+IGasTpM/6LzeFT5yJG2TU6X3TKSkJ385a+2Pbzh0IgAuKC/AoNByQH4zEUJkFnY3DZ/d/AESg6jv7LXg1ObLTE=
X-Received: by 2002:a17:90b:4a91:b0:2e2:a3aa:6509 with SMTP id
 98e67ed59e1d1-2e9b1697bf5mr11996579a91.14.1731237402258; Sun, 10 Nov 2024
 03:16:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011102751.153248-1-privatesub2@gmail.com>
 <20241011102751.153248-2-privatesub2@gmail.com> <4ioz6f6efs2uhf5mitb4xhebqeryyz5ukple4fkn54wpqep3c4@4ktefld35c3s>
In-Reply-To: <4ioz6f6efs2uhf5mitb4xhebqeryyz5ukple4fkn54wpqep3c4@4ktefld35c3s>
From: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCo0YPQsdC40L0=?= <privatesub2@gmail.com>
Date: Sun, 10 Nov 2024 14:16:31 +0300
Message-ID: <CAF4idNmDMQpFppUvCBbC1=SNMQBrTOqmFO60SMvKvaHvNJy=Bg@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Cheo Fusi <fusibrandon13@gmail.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Uwe,

I appreciate your suggestion to use a more standardized
property name like "pwm-number" instead of vendor-specific names.

Since the name "pwm-number" is present in two drivers,
we could consider using this name here as an option.
Or perhaps we should choose a new common name "npwms"
as you suggested?

Please let me know what you think about this.

Best regards,
Aleksandr.

=D0=B2=D1=82, 29 =D0=BE=D0=BA=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 11:56, Uwe=
 Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>:
>
> Hello,
>
> On Fri, Oct 11, 2024 at 01:27:32PM +0300, Aleksandr Shubin wrote:
> > +  allwinner,pwm-channels:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: The number of PWM channels configured for this instan=
ce
> > +    enum: [6, 9]
>
> I wonder if the number of channels is a property common enough that we
> can use "num-pwm-channels" here instead of a vendor specific property.
> Or would you suggest a different name? gpio-controller nodes have
> "ngpios", so maybe "npwms"?
>
> A quick grep suggests we already have:
>
>         fsl,pwm-number in mxs-pwm.yaml
>         st,pwm-num-chan in pwm-st.txt
>         snps,pwm-number in snps,dw-apb-timers-pwm2.yaml
>
> As a follow up this could then be used by pwmchip_alloc() to determine
> the number of channels if the passed npwm value is 0.
>
> Best regards
> Uwe

