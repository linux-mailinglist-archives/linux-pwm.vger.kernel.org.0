Return-Path: <linux-pwm+bounces-7025-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A4B22CE3
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 18:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F74503C0D
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE6B2F744A;
	Tue, 12 Aug 2025 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaq81jzu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB592D23BD;
	Tue, 12 Aug 2025 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014828; cv=none; b=dROtD+RrE2Mr5D/6FmJTMcAe6Ntf8oSWiZJFDpiUdcF/nY1IqT5Y3BiYeABaMJjUetU20QcMA0LwL4dxlZLNrq1ztr2ZwTd+Ex8ReA7Zi8MU+ziyQt4w1LgnyS8LiiZDDiCu9zalUGkaf97nYWXYDr7xe/J+IKdJx7jR7g0ouaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014828; c=relaxed/simple;
	bh=Ytc/zUrzwB9dSfRBauFdcbu71JNKslEJKNBjtaV7crM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxVHnpeV5nYeIKpR1NSUOa9qVLAl9FXj0KsHDCyC1e3AsMp0fK2Se8XffEXz/e1uAC3mx57/JbUZMtOTaLThkGaE8r0ywSDO3DGhKtY03MWThPpwMJHLpS9zmoQl14ICcawLAc8uEAqQHCSAlcrGY9nu9xHs2Oa/83GFf9mXPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaq81jzu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso4204086a12.3;
        Tue, 12 Aug 2025 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755014825; x=1755619625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWD/q9Pu6tuIO1zcj78ludL13WR9lqGaWH189kTkSRM=;
        b=iaq81jzubbfP4QmhkQViA2pqRNr4pHfHevEqsIQF32xnE+elwiQLV58dK2d+6DZd4c
         fW3hkYHQq1G0qCMdmp50pa6fS9LfiIgGBp3KeX/yDEc4Izhef/O8X4CvX1+I8CeNNfeJ
         YkzjChCjNzzZpZKYr9/OJS/RkRN5WR4ePXseHR+3e5wO0Dy8/2FInDMTPEMEM0XzmOyy
         5IfWuUdLgGzBE3SH0mXbskSekqT5vK2kbesVpKpRzOnh4nOHtoDUO2QstSfCO34j5jQA
         RrC1a7bbnJ/sqV0YVcPZK4dWWkrPB7Z9D0U6foP2BbfrpCQh1cJHRTS/I6t6zT0GfF3A
         tbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755014825; x=1755619625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWD/q9Pu6tuIO1zcj78ludL13WR9lqGaWH189kTkSRM=;
        b=V+cfEjjWXY48Btog446hBhUd8ZKglusmLKskvxnLNFbfZdGySY6S0LY98HWpkpqyi0
         MdwZdNm+EymbWN07McD3NHDQReiSjRyHZ+Oihn0Nf/xST+xzat+cIyayZHWuuJxQ7I84
         AfP2XS/FT4c2++u0fIWDyN0oy8QZCyUdSCazX3mAp4xc5fwb8A4o5BVNE+NwonntBd0P
         w/e1xPFC/GwWw8vkTUZ7ybFiJiox0xmssecfZG0cI9p0BdyeIAicgTtaSEARMXkmsph0
         4WbIyCPtwXUY1oeX/eAbTJbYZi2YzY9VVKic8awQkiT1MoS6DjzsQyw0/weWzXzbIMCS
         Y+mA==
X-Forwarded-Encrypted: i=1; AJvYcCUhUQGAOHKMQ2flyFKApPfWYBKuuzfF3pTcxu0C4+HGpE4DP3/to1T3gcnKwPqIpVgdLvMoOmIOpZ9p@vger.kernel.org, AJvYcCV5Qu6g6rM+9qvBrPjzV2xhzkwq9FDwVFaPGDJDnemyq1qpADmqBJY+rycfITDHOqy0htvNb0MFbBO87r0=@vger.kernel.org, AJvYcCVqZ/m1g3Ue2GT5dVm2qu0w85dD3b8XGJqxjBeQqURD8eflo3Dcvouff1xboUBV2HrkIHQx1n7fZ7od+SMT@vger.kernel.org, AJvYcCX7fBTc+iI8YpJC7oeYmArV0OqRZwdTExlUuQQT2wp29a34hvgdN3mrphzj5lqaCUn6qqTKz5oiqQG2qpI=@vger.kernel.org, AJvYcCXOSaDDOK0XAOk91LEV0Az4roALhLfPoB18Uuu48p8/vnIp5ghFr86s43o8KoOaJ7rm60wodBxqdsL3@vger.kernel.org, AJvYcCXf8jAfqmkHl44l6TXBYSINh65IqouMzHzqTFZOLRVj86T5m2tOhxyX3U50uA/z6MDC9k7wcVggpEDd@vger.kernel.org
X-Gm-Message-State: AOJu0YzTb7PX1debUzM4osf3mDK6fW08EWslf0SSFnwWy42BbaSYzzyI
	WFuydw8JFTyIRY+cEjNh9MIGzQChA+u0eqxvx2D6MNa1UOeL36tzFy3//1uwB0mAc4XRvNI2LJk
	ZjfvASgKRtvi6OME9jwPvzgUNcOOALA==
X-Gm-Gg: ASbGncvIrrt2VMc7YT9kNAFnNi1i58imvmYsvjEQjKVaFqatIePs7GVnQQniK5nWWc1
	w+QIQ0zTmxikT8kLPNLQhMi2MhRdPd72sGKRN/oK0hY0+aYXdU0R3uN1F8YgaRanwAEjZoetXeI
	NgPyJh1R5rGSzbw8e1cpo7ThyE80G0lWFowTIqNWOfC4BLUGU4XTWeliRHO7h0RobrveAVcvxHG
	/k1zYcezQLZrBzkAJjO2BmFJSxok9WYJMnKqLPI
X-Google-Smtp-Source: AGHT+IGW5pCpqLzEodQ19/HLE+9BnzviR/vNsst9m4Z0sAGeEHuJw/w0Vavx6Mj0QxG4tcsN4Bh9+2GzbOI8KUm/MIE=
X-Received: by 2002:a17:90b:2741:b0:316:3972:b9d0 with SMTP id
 98e67ed59e1d1-321cf5a35d5mr243637a91.0.1755014824534; Tue, 12 Aug 2025
 09:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
 <20250811224739.53869-3-jihed.chaibi.dev@gmail.com> <175496188325.1486426.9118766970247515386.robh@kernel.org>
 <20250812145415.GA3607226-robh@kernel.org>
In-Reply-To: <20250812145415.GA3607226-robh@kernel.org>
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Date: Tue, 12 Aug 2025 18:06:53 +0200
X-Gm-Features: Ac12FXwfs7gQCuFv5_wFnT7JV_t21r8v_U_rYrA5Xk0a8DpDja3Z3yXcrMr6a6w
Message-ID: <CANBuOYrCAcgp+x+TL98V3ih_ThyPF7x6VgXxVi4YnAdOC3nZvA@mail.gmail.com>
Subject: Re: [PATCH 2/8] mfd: dt-bindings: ti,twl6040: convert to DT schema
To: Rob Herring <robh@kernel.org>
Cc: tiwai@suse.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, ukleinek@kernel.org, krzk+dt@kernel.org, 
	dmitry.torokhov@gmail.com, broonie@kernel.org, linux-pwm@vger.kernel.org, 
	lee@kernel.org, linux-sound@vger.kernel.org, lgirdwood@gmail.com, 
	peter.ujfalusi@gmail.com, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, shuah@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 4:54=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Mon, Aug 11, 2025 at 08:24:43PM -0500, Rob Herring (Arm) wrote:
> >
> > On Tue, 12 Aug 2025 00:47:33 +0200, Jihed Chaibi wrote:
> > > Convert the legacy TXT binding for the TWL6040 MFD
> > > to the modern YAML DT schema format. This adds formal validation
> > > and improves documentation.
> > >
> > > Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> > > ---
> > >  .../devicetree/bindings/mfd/ti,twl6040.yaml   | 155 ++++++++++++++++=
++
> > >  .../devicetree/bindings/mfd/twl6040.txt       |  67 --------
> > >  2 files changed, 155 insertions(+), 67 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl6040.=
yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/mfd/twl6040.txt
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/mfd/ti,twl6040.example.dtb:
> > twl@4b (ti,twl6040): 'twl6040,audpwron-gpio' does not match any of
> > the regexes: '^#.*',
> > '^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|gpmc=
|hdmi|i2c-gpio),.*',
> > '^(keypad|m25p|max8952|max8997|max8998|mpmc),.*',
> > '^(pciclass|pinctrl-single|#pinctrl-single|PowerPC),.*',
> > '^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*',
> > '^(simple-audio-card|st-plgpio|st-spics|ts),.*',
>
> You will need to add 'twl6040' to this list of exceptions in
> vendor-prefixes.yaml.
>
> Rob

Hi Rob, thanks for the feedback.

Wouldn't it be simpler if we put 'ti' (the actual vendor) instead of 'twl60=
40'?
No other file is using the current name, so there would be no need for
additional editing.

Cheers,

(CCing everyone, sorry for emailing twice)

