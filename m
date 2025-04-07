Return-Path: <linux-pwm+bounces-5347-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F7EA7D39D
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 07:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2963AAC3F
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 05:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0399A22424E;
	Mon,  7 Apr 2025 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwRK/2Zh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F472236F3;
	Mon,  7 Apr 2025 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744004326; cv=none; b=hYK/7w/OBAfJ1XVz+UWmK+81LrUB5T+xlbhv9R53WQTP5Obdw6pns7JAGRAxzx3aznRLIKu5NIjy3AyPIJ8BUL4frpkfqutmQMURERMcUT/kSm3O8OB/STpdvJJDrAhO6Y1DOJGBXKHhRcXGMmyR9R+nKzOUS8/kdwy787w8EHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744004326; c=relaxed/simple;
	bh=hvves4toXk2gLEBXAQSEPuGfDWPqF2N/IQRJ3Mjnmv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOqUcYHLwjV1v22qE1ag97lfDE1mw3Ns3RnizdqN0fCg0ibij/XfBxFdEAcqtHafdk/QRtAcoMoqW/k+6i6OmbreKlWqr6C9+IOZFunDhlIbHvkIF4Wbcii/gEk9h3tkLUdUY/3Uq4bzQTfzcFZLWvZiBAxp+pFIlBsUXUrjTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwRK/2Zh; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-306b602d2ffso1275352a91.0;
        Sun, 06 Apr 2025 22:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744004325; x=1744609125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axcpWb0CiJMv6x26lX8+ffH+IwdPQ6J2ls63frRS//w=;
        b=LwRK/2ZhxEzfs9QBMPB0p4+PXyGWXBCjA5I/jNnK0kR56wF7ZNtFcx6FDDl5fxjlOi
         jnutT7h9iNcZdg8APXlo/JHufaht16RejJImMHI8N6zyFk8aJm9ZIB96j9Nyr8vXp6Sh
         QgkptlunC+yMT7CESyfz38Y2wrZwf9hW4eFvENXQ7ZmBhgwoqfnGnL4k7gz045/O2wQf
         pNVYdEWy2nxZP+JKbq6uKd/dfYQE/vK+N5e/o/Kt24FX0uJkBKDvaN0om4Aa8e5d1VOg
         xfLR9chmhJTsvqrXoxktLK3p5QUvaYzGoUy+tKzrnwhwhy2YfYc0ohNPdQMo3MDgxHEy
         sRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744004325; x=1744609125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axcpWb0CiJMv6x26lX8+ffH+IwdPQ6J2ls63frRS//w=;
        b=SeZXRinqFERs47tfeFVJxDgU7u1ceHSsTk5O0/6gB4/O7Z1b2ijUG0YkkFJwbhAahc
         DDh954O5cF37iPNmhBonndKDAQ/G9ju2z6XyhYE7b5fGLKUlvGwSoOPwX1CVjOCzeFfY
         Tcbbj5UECLw/fMkwYuqLIzalL7dMrEOjE2MQWOuWUgsQ3XiZfKvm9fLApXq20vzwkDvy
         y2SS6Ues/5AJWcV0Y6MPTj5ypOvt/2i3Bdwrs1KfD8Vtv+c49u5qQ/qUvGqYxN6IqkI3
         g3NsqyXdx8i8HaST0iM5gBy3N0fmsprdDae5LeLNgchMhMpBHQUCsFuTxzNhh13pvJHm
         8nCw==
X-Forwarded-Encrypted: i=1; AJvYcCUBEaUd5qH8VjLf1kYmIdIo7ENSZk+FuF//0TsiXbCU4I1iJ7I9AsDDRkHsvGnxzU4l+MMwbudLNbSohA/z@vger.kernel.org, AJvYcCUEs3QJscwJKb+6gY28ZzTeRxlLMljDKBNwxSaLL6MqOhxzWA2VVBr2h1LR2ztgmLWKQYoqBXlUHQoH@vger.kernel.org, AJvYcCWceAbQFHJdxAvqbHV4wqHltOo3hUqRCFSKcT4XAekrwQeLJCPLF+e1KPo6RnZF3/AFvniTpIbxveL7@vger.kernel.org
X-Gm-Message-State: AOJu0YxLGnvJan+0DfYT0b8/fsrYpRy36OiLv9OjuaAd3eoVRTmw/kDl
	qYauTBf0l3n8kSGCQ+6M0AUUCffk9fM1jIx7JII2P/ZM3nK1wuMCVsedBlg81WxRNB3j+18BTlx
	fQC/yint0c5gUFpHgKDINmHuhVEs=
X-Gm-Gg: ASbGncupVzhRfZ94rKunqyKvao70+YHs8k4iruFhqBIso9AohP8aCvHZxxX8opKU4Om
	UJoHVpSpW3EGcHWxHPWyQNQ3fcMPWDd6SsUw00+vlAOw9ZpFe3UojkF683gtFt2bFP4uTMMWrqJ
	txs6pRW+Ft0S36FwQPslGGt4C9/HBuU5gnsos=
X-Google-Smtp-Source: AGHT+IGndqGRW8avHxtl3qnm0RlH6ICqsq3r3bvO1qI0RAfBt8JObOMkl82WtVLXKzSMEnJm4hSuODChzuGE5fFuW3Y=
X-Received: by 2002:a17:90b:4ec8:b0:2ff:6608:78e2 with SMTP id
 98e67ed59e1d1-306af746455mr12866112a91.16.1744004324069; Sun, 06 Apr 2025
 22:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
 <20240501083242.773305-3-qiujingbao.dlmu@gmail.com> <k6jbdbhkgwthxwutty6l4q75wds2nilb3chrv7n4ccycnzllw4@yubxfh5ciahr>
 <D8Z4GLQZGKKS.37TDZ7QBN4V4N@bootlin.com>
In-Reply-To: <D8Z4GLQZGKKS.37TDZ7QBN4V4N@bootlin.com>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 7 Apr 2025 13:38:33 +0800
X-Gm-Features: ATxdqUHIt5xrCNGwJLh7UoP-kFxlH9HUctmkFVMByLT_ziJVw0ZWkg8cIzGt-ig
Message-ID: <CAJRtX8S0Zg7-Rba6ziaAoBi-2Bs3N0NfpguF40T16yObaxCZiQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, unicorn_wang@outlook.com, 
	dlan@gentoo.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 6, 2025 at 8:16=E2=80=AFAM Thomas Bonnefille
<thomas.bonnefille@bootlin.com> wrote:
>
> Hello,
>
> On Sat Jun 1, 2024 at 1:53 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, May 01, 2024 at 04:32:42PM +0800, Jingbao Qiu wrote:
> >> [...]
> >> +    if ((state & BIT(pwm->hwpwm)) && enable)
> >> +            regmap_update_bits(priv->map, PWM_CV1800_OE,
> >> +                               PWM_CV1800_OE_MASK(pwm->hwpwm),
> >> +                               PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> >
> > This looks strange. If BIT(hwpwm) is already set, set it again?!
> > Also if you used the caching implemented in regmap, you don't need to
> > make this conditional.
> >
>
> I was testing the series and noticed indeed an issue in this driver at
> those lines. If PWM_CV1800_OE isn't set by something else than the
> kernel it will never be set and so, there will never be a PWM outputted.
>
> Using :
>     if (!(state & BIT(pwm->hwpwm)) && enable)
> Solved the issue but as Uwe said you can probably rely on regmap caching
> to avoid this condition.
>
> >
> > ...
> >
>
> Do you plan on sending a new iteration some day ? I may have some time
> to continue the upstreaming process if you need to.
>
I am so happy you can continue finish this patch.

Best regards
Jingbao Qiu

