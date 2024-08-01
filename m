Return-Path: <linux-pwm+bounces-2957-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7795E944FAD
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Aug 2024 17:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1511F23FD8
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Aug 2024 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB8F1B142A;
	Thu,  1 Aug 2024 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2gvlFkB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2013D607;
	Thu,  1 Aug 2024 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527554; cv=none; b=WALWhGDuMn69Zy8zdQmRLn/FHII3/hou+vTe/vPTV63g5EkfLCKjMYNDNDdncyYs6BTkSmjilUSz610Hh3qceGLnGTu9J5m67lbt8imA2iTygDmMhgPq0Yl939zCeZr7/4F80W566vu1AaeLHIhyhf16KOz8kzPVMRnQKDPESVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527554; c=relaxed/simple;
	bh=M2awlnuVIb7q7ON0ymnh9ZeygvkNsLVWlFARl99BxbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppObBeWbK7ZhnwdNNX4URAb4FT1GnoXAr6DN6TTaVoGD7LO0U1rzxvZVU28x/JGEt2Z4ZBBMl50OgfjN3q3OQdxGtyDBWmuA0qvQdz45nLAWWDXW8pVyskF7UQFVTOFFfNEVzpKzwlHPsfuQwu+KH860N/50Jc6DXfv+AojyI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2gvlFkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F239FC32786;
	Thu,  1 Aug 2024 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722527554;
	bh=M2awlnuVIb7q7ON0ymnh9ZeygvkNsLVWlFARl99BxbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N2gvlFkBghdESWRujwP1g7r+eLsIjkTvp4CW9zm6nNWh5JJlFKnFTwge4LTW18eqG
	 AvzAj3m/uAk709Ms0GQtqt3hgWkvwz1dlECCt41kSflrErGzSQhTlVoTvzGignXfyc
	 Vj0t/MTh3yAGuD24PzZ7qQsIEiK/mFsJW9Fz/txIXiWPYEfAUeAE/16Tri5cVOfyxL
	 WLgkoO+9R51ZU3j7x1gkKNpcrLqXQ+rfC+8L/8paUfGfIWKjkn5/TsrF7OM16+c5P4
	 ifK3TQJDR8yVw7eShbeWO/xWUKw6BWfkntt5sQKNfM9fmqx/LDKksQZifudmICsqRR
	 8zJ9QsfRomqJA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso8494715e87.1;
        Thu, 01 Aug 2024 08:52:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/SUh72T4fArIs7SEOeysHRsYfSW5LKZg4r2T0Qy+DvxwHfyRfk+QWqLdyt/4kTEnWKFZvTwqwczUZf/LjE5qHfA+ZLRVhBEYFWhHe
X-Gm-Message-State: AOJu0YxnlGfxgqHj+VvDTULnX9H37fEPZRbq66uq/yQuUqptAx/MNyWq
	+eMrg41L5lAwD4zyOaTpWtTSi/PvSAg4BHtYXG1em4c0mNWQEqChrmw6gY0Fz3YCr+H1orsRh4u
	5B9sC51iBa2lL+993sv8R6TCpDg==
X-Google-Smtp-Source: AGHT+IFBy7uCa2z8APna5B/22Jk4LuAl6shrXKzQUU5vKBktSU5VfCpd/1JGP3B6jsChAmc4GdsO5CRCPRbdgK3NaTM=
X-Received: by 2002:a05:6512:3343:b0:530:ac0a:15e6 with SMTP id
 2adb3069b0e04-530bb3883d6mr226956e87.12.1722527552351; Thu, 01 Aug 2024
 08:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731201407.1838385-8-robh@kernel.org> <xz4mlhgxh4fqi3ken5xzam4xzmjbfpmyxs76pthofqathbcobc@3wdrnrca47qh>
In-Reply-To: <xz4mlhgxh4fqi3ken5xzam4xzmjbfpmyxs76pthofqathbcobc@3wdrnrca47qh>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Aug 2024 09:52:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+rF0fTDh5-gQWfmijkBuDOoxJ4M+TVvSpUgWgeOhZBA@mail.gmail.com>
Message-ID: <CAL_JsqK+rF0fTDh5-gQWfmijkBuDOoxJ4M+TVvSpUgWgeOhZBA@mail.gmail.com>
Subject: Re: [PATCH] pwm: lp3943: Use of_property_count_u32_elems() to get
 property length
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:58=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello Rob,
>
> On Wed, Jul 31, 2024 at 02:14:03PM -0600, Rob Herring (Arm) wrote:
> > Replace of_get_property() with the type specific
> > of_property_count_u32_elems() to get the property length.
> >
> > This is part of a larger effort to remove callers of of_get_property()
> > and similar functions. of_get_property() leaks the DT property data
> > pointer which is a problem for dynamically allocated nodes which may
> > be freed.
>
> To understand that right: The problem is that of_get_property() returns
> pp->value, which might be freed. In this driver this isn't problematic
> as the returned value is just used for a NULL check. So this isn't
> urgent and queuing it for the next merge window is fine, right?

Yes, 6.12 is fine.

Rob

