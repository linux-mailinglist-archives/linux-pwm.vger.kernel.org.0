Return-Path: <linux-pwm+bounces-3084-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FB996A73C
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 21:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD2E1C212EF
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 19:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0EE39ADD;
	Tue,  3 Sep 2024 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5Fm1kNo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A781D5CC6;
	Tue,  3 Sep 2024 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391155; cv=none; b=gMzcVYD2mh2iIusiAapE0I1B8Vo5G3UFmMdhk/MvjvqT+rEQiWK8dycn9li1Qzml73/Ys/Wm885HLOdoz9oZ3jtRTYGLD1z8ezQlhGuC7j8dShH78jTNjv3wUlrpjC/ZFcTpCN9LHHz4YhzFw280g2lXSYpQE3mvJgJSC011P8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391155; c=relaxed/simple;
	bh=zNBJb0Am3LrwammltYmj+EDx77Wu870OUwPwLSva0Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWyWdYhDngwjVF6qmb4CMC4gwyzRSpHOUkLodcYMgjmcYc1Tzl+NWXAOa6MUTkkSpAebHHw3+40EvgGo0NJc1s2sGYz/u9csQ8mbTrOvjH87tIFe8LdNsn4OE1lPmayxVQ3yhenNEci5QWNzdib7Phl80E932ni0zHUKnLzoX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5Fm1kNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95D9C4CEC5;
	Tue,  3 Sep 2024 19:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725391154;
	bh=zNBJb0Am3LrwammltYmj+EDx77Wu870OUwPwLSva0Kk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i5Fm1kNo6Njs/8OMK+wEuuN2H/hfoFd6a4G550mCsgTzLrwvaoReBIOkcNfx05lkG
	 8nPXuR0ItmLtQwFERkiWkL+fVJ76kSX3xHhLnaSFVSsmvqAyjKceVXiuyLYNbcNnya
	 8cRAukeur12wBFDaA9ANifGcB3R5GLUOftzEE7VNJDbxnEUCZ1qI52EKi9HezsOwxX
	 xDb5H+G+lO9Ld9QH6DzMo6x9L3qZaP5Fkcm+7QoDtdY1m7s0Kl/PQH93C4XWBwKoMl
	 9oSxHtGwKSURi5pavqtxFwPFRDcp0e8KWoI14MgcX6UC5amB/vFn2HwldTUve6OQyF
	 jLDo0XEhIcEcg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5353d0b7463so9699307e87.3;
        Tue, 03 Sep 2024 12:19:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUF4G6XRza3N8f3B+Mgx+tqciFpc67JVYAwFOO0eDPJ/Oqj0jzVvZlZeX9uVKT8W+/3wimrhJQSfzVHag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0SqB4OfCR8u4V5ZGHk7fmYAI0TId/4cPz9LyUutgmhzEGzCP0
	uAg3hCThVcedC0EZ3F4TlhE86JU5KGuzBa6ubOqv2ayM+dVs6PgKhxZBvU485SxMgmgdShx35NB
	BYiWZG4lqZsyR6ObLzAH8hC0dYQ==
X-Google-Smtp-Source: AGHT+IHSSH7/wsWs18XW1gVFkfqHT1Iv/ZsuHjs5Zrf13IvWU0WXtsE+RVuZ46asRbfT35DuRPdXhJujD4r2ukvbUds=
X-Received: by 2002:a05:6512:3b14:b0:52e:9cc7:4462 with SMTP id
 2adb3069b0e04-53546b1dea6mr13937464e87.11.1725391153329; Tue, 03 Sep 2024
 12:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731191312.1710417-25-robh@kernel.org> <syfawfdkulanw7kile7qfg5qpfzakaqolh2qkjqwyarskgg2sg@ond7ytjil2yi>
In-Reply-To: <syfawfdkulanw7kile7qfg5qpfzakaqolh2qkjqwyarskgg2sg@ond7ytjil2yi>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Sep 2024 14:19:01 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+GVSwiEVRRcN5xL7pgOn7rRNLsWU8s-5ByCP4rpj9JGw@mail.gmail.com>
Message-ID: <CAL_Jsq+GVSwiEVRRcN5xL7pgOn7rRNLsWU8s-5ByCP4rpj9JGw@mail.gmail.com>
Subject: Re: [PATCH] pwm: Use of_property_read_bool()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 3:41=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Wed, Jul 31, 2024 at 01:13:03PM -0600, Rob Herring (Arm) wrote:
> > Use of_property_read_bool() to read boolean properties rather than
> > of_get_property(). This is part of a larger effort to remove callers
> > of of_get_property() and similar functions. of_get_property() leaks
> > the DT property data pointer which is a problem for dynamically
> > allocated nodes which may be freed.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  drivers/pwm/pwm-omap-dmtimer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Looks good to me. Unless you object I'd apply with adding
> "omap-dmtimer: " to the short log.

No objection and sorry I missed that.

Rob

