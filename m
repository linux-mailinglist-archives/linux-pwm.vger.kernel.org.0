Return-Path: <linux-pwm+bounces-3749-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D339AB35F
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 18:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F791C22842
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84861B07AE;
	Tue, 22 Oct 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFowMhYW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B41A7066;
	Tue, 22 Oct 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613172; cv=none; b=aYLcCv1g4XCdkZ6+GJIvEXMKalz7PjLlYQN7WyzpddvvZ1FhCjiQMkmdKh9zsvcI8x9AEHCuMvMOjtpX5Leos3mk4KCI814ISA/aGTlbZQVqiMwGYjDg/VL+EA2y/bUXifam9kw922nIlcv/fOHZzJFt++zQr0f8YJ83xiU3ReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613172; c=relaxed/simple;
	bh=oRFDm+iedatU2fV8V3MjHkys9bVf+nOjhkvEO5L675M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJjRTkEXscsO/NvV/Hhr/mDNHzMXdSQ/UAmsM1lsI7qVps3yhoJcHR5GzREqbeqDSi+KghgUyucmL5czXAVInFEW+lGiTxZEb2m4OYEcUwS/SKHJ+pVfO7pxcFd62qbJHO+Fl7KEBHWFttXffF+Zmq96kLKhmx+cHZexLDodPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFowMhYW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso49991215e9.1;
        Tue, 22 Oct 2024 09:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729613169; x=1730217969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fxWrldtj8CkDnO6DhUP04cjtdJoNzqSbZK7oqpPnv/8=;
        b=bFowMhYWYIZDpDv+K1RAbOh7CwXPkYsGSSi3TGsu4wkdBqqMLMQqmbln/2pDW5OuSz
         MMLz2ZYdErP6J36cMPPhEo8t6BMXwwV3gfGuBi0AlFVpbhm1feXmlXjX9mwWkpa4jrlH
         KQrM9Ji3pnf62zVUvFIPh5KrdwWdyawwInIkAQTlK5cvOAMQcQNKDqbRrNOdYVdY//Bz
         MtApJXmLTrS6S3Wgsgbm+Z8p06/fsa+Vn/u5Cqwe0X1io3q1Mehi3EigoOUkQzNxC/Zr
         /f2Q6bjDHiDy9RNXM8HlxrrDaQ56vr/QMpGzVQB4IfKW59lvNXfraAJ9Dna8a97+JDK8
         c+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729613169; x=1730217969;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxWrldtj8CkDnO6DhUP04cjtdJoNzqSbZK7oqpPnv/8=;
        b=XlWY+8OiVGOixgkjNgHCXp/84Gv9LkW8HlLJ26rqlSf6I9Qqdd7fvWYgCuJJ7MKHUo
         VzONUbLannl2VseQQDsD1oQt5S7TGGdNX2q0wm2BPH9nNLe0YJbON9rHMW4P7nolPErH
         CoLZ/cec4WI2icpgMkzjYRX4uunlyOzNQ4QA6tk7rdK/Vls6gd2llDvFUwXluXv4rY9O
         p2wP74LgjYrME2lJM1D4NzT0ZXzrSKDMZessAw15P4sTxrKAI9NvRWvKOyaVG3FKbw0p
         fCeoWvI9K90lAkIqTFyRQNAcXxRS8aGdMg03xz8Gfow6jf1ATspJ0luUXSw+Izg0j18T
         FA2A==
X-Forwarded-Encrypted: i=1; AJvYcCVdNL/snafsVhKCR70mFZV7iLiYhziEvsKH3fKmKy3b83/jETZX8TBw36iyecUsqXmXBhSjqNHEj8XH@vger.kernel.org, AJvYcCWjLrKhpkOHsqHYNn59PYv2NA9nj36t2DBPJTCj7Mf2wgf1e/usLcQ84oYyX8q33LPagHAxdkcL47W5@vger.kernel.org, AJvYcCXxfqfJtE9tD/rDDR/S3JNFRFND5xHpSe9SxsZ3wThePV9U0C408EUTdgVbhqWReFTa5OR3QvXpFw1o2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfEYEh0yTkRogycc4/dFSvmzJmx38DDV++WjDc6HAlNOsZcxrt
	UX2Dxb+aT74S8fBEg4z4AKWSEU4tK+N/CQLy2Cnpmr0hbHn/qZNv
X-Google-Smtp-Source: AGHT+IGn+ZvQ2I0cnepX3Iem8TmtbcezWfjPrq8BYpHnSfPOy22mKwtv0GTJLAfmSkZIvd++rl2lXA==
X-Received: by 2002:a05:600c:4709:b0:430:56c1:644c with SMTP id 5b1f17b1804b1-43161693a2emr116369875e9.31.1729613168980;
        Tue, 22 Oct 2024 09:06:08 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37a2fsm6921282f8f.22.2024.10.22.09.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:06:08 -0700 (PDT)
Message-ID: <6717cd70.df0a0220.850c6.7b5d@mx.google.com>
X-Google-Original-Message-ID: <ZxfNbgbroaqiZhkf@Ansuel-XPS.>
Date: Tue, 22 Oct 2024 18:06:06 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v8 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
References: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
 <20241018-en7581-pinctrl-v8-3-b676b966a1d1@kernel.org>
 <20241021190053.GA948525-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021190053.GA948525-robh@kernel.org>

On Mon, Oct 21, 2024 at 02:00:53PM -0500, Rob Herring wrote:
> On Fri, Oct 18, 2024 at 03:19:04PM +0200, Lorenzo Bianconi wrote:
> > Introduce device-tree binding documentation for Airoha EN7581 pwm
> > controller.
> > 
> > Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml | 61 ++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..fb68c10b037b840a571a2ceee57f13cbae78da66
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/airoha,en7581-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha EN7581 PWM Controller
> > +
> > +maintainers:
> > +  - Lorenzo Bianconi <lorenzo@kernel.org>
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: airoha,en7581-pwm
> > +
> > +  "#pwm-cells":
> > +    const: 3
> > +
> > +  airoha,74hc595-mode:
> > +    description: Set the PWM to handle attached shift register chip 74HC595.
> > +
> > +      With this disabled, PWM assume a 74HC164 chip attached.
> > +
> > +      The main difference between the 2 chip is the presence of a latch pin
> > +      that needs to triggered to apply the configuration and PWM needs to
> > +      account for that.
> > +    type: boolean
> > +
> > +  airoha,sipo-clock-divisor:
> > +    description: Declare Shift Register chip clock divisor (clock source is
> > +      from SoC APB Clock)
> 
> Where is the clock source defined?
> 
> You can specify the PWM frequency in PWM cells and should be able to get 
> the APB Clock frequency. Then you can calculate the divider.
>

Hi Rob,

this property is related to the Shift Register chip and is not related
to the clock of the PWM.

It's really to configure the clock that will be feed to Shift Register
chip if for whatever reason one OEM mount a different kind (but still
register compatible) and requires to run at higher clock rate.

We can consider hardcoding it if really needed but considering the case
with 2 different kind of shift register supported, I assume configuring
this might be needed on some corner case Devices.

For the clock we are not 100% but we might have an idea of what is the
source, but still it will be just referenced and enabled in the driver
(it's always enabled).

Hope I can get some hint by you on how to proceed.

Is it ok with:

- Defining the attached clock
- Keep the property

?

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 32
> > +    enum: [4, 8, 16, 32]
> > +
> > +  airoha,sipo-clock-delay:
> > +    description: Declare Serial GPIO Clock delay.
> > +      This can be needed to permit the attached shift register to correctly
> > +      setup and apply settings. Value must NOT be greater than
> > +      "airoha,sipo-clock-divisor" / 2
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 1
> > +    minimum: 1
> > +    maximum: 16
> > +
> > +required:
> > +  - compatible
> > +  - "#pwm-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pwm {
> > +      compatible = "airoha,en7581-pwm";
> > +
> > +      #pwm-cells = <3>;
> > +    };
> > 
> > -- 
> > 2.47.0
> > 

-- 
	Ansuel

