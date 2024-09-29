Return-Path: <linux-pwm+bounces-3398-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FAC989710
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 21:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC6A2825A4
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 19:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D09C5674D;
	Sun, 29 Sep 2024 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3aI0hXq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEA72C1B4;
	Sun, 29 Sep 2024 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727637753; cv=none; b=cAmF0xZCdK9SRqOX4TOs18Bz0Gm9AEvJyDuvj2pcVbjNG+JJ2BRFBskcJfkajfBjudlCkz2b3JXxDcwqcCNWqtijh5uQsQCJRsZX4AXvb9A25w9gtekRgLikL+cl6piqST8q2ANz2Q7J8iJBUWLpTZX06t7tG3j/GHv1xMZTluc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727637753; c=relaxed/simple;
	bh=oLXxoh6aKOly9Powt/xFXlfDVV5wCoeAxlXMnKhDi6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGJ9qKTSTv1BTGJWjtLqy0mAtSEWbgIhaF3pJkkMSjXyyyFZm89M7LxqZTq9Lj7oxfOyRBJd5jaKCbAMJzBRmvTu/tGcfVGFewCaafFpXGYF6RJ3T85dOYqqIOpHOfOaJV1Gerkz73bUuUpSI3WB/dTWbAjBEhteICRbV1dMJI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3aI0hXq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c8952f7f95so760678a12.0;
        Sun, 29 Sep 2024 12:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727637749; x=1728242549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pobc+AJ4aXejENeOegO+U6SgRutUJx4h2NJgcJv9KmI=;
        b=i3aI0hXqpyd8gy7P7yBb18DMWn+OSmtEwK+yzPmsbr0a8yVG6cskE7iQ+DoY4xqoZ2
         0bLPzdiNFn52RL044KtbXjyZ1jKi15pVbhcDC4TNqb1oC95srrusCjRyJjMValt7bOqI
         SwDW4f+NfQWPHTiG6/SypQ/9uOISTewyChVSgnl6gvj8cMEWmbuNUl7wRbdkXsYKmEs8
         yQIVYxR1yW2RbGADxTjmIo3bfFwQco+6NsIKxLmfiTGylVr7uJsKeKBIMd8ylFxdhmDB
         qOqK+0QeqK3HPNlB4jVGS78VxVGP/hqz9nNJbFjJ8D+me4sZxUiYj9OAQihKXOWVxczp
         t1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727637749; x=1728242549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pobc+AJ4aXejENeOegO+U6SgRutUJx4h2NJgcJv9KmI=;
        b=lHmHQ057VCl0kvp4QYIByelq8aHmRubREVrZBzfnaxuriNNbZy4rVMjCP0tEuq85uh
         H8PFmZv07Kh60kzjk2WXLPxVEl5MKA1D+F9k+cLOeGudvjD3nC5871NFvAm9kjLH8p4U
         IF2QuNnCfmpjgW/pITv2JEraj6EK84NpsIM0HhP0VCJ4sVekr1aMga3a0Nm0WztkN3sH
         OJCqsTi7Q0ApLzJjqX+H5+bSYHi4WwPOzwT5iQv3swyv0U/5KRtNQBclEL9F7FqoywpT
         YtzsBDeAZUEjS7S5fyqdOTDUg9zRkrmtqfhVFo3Ackbklhion9fJWWtx96JDx4NZ8dcI
         TMgA==
X-Forwarded-Encrypted: i=1; AJvYcCVC2EeYVnaixfz5Mi1D7uA8B9DfYVuT03wfqe79HlUaRauuu8rG9Q1zJvOX/6MDQ88dXAcamFuRf2sQQbVe@vger.kernel.org, AJvYcCVN8TQ8xXvesQKz6bCJTcWFJdW6vgJR00sAgqYx131ls2NjqUPmMyh8fGCU6hou49fgdjFZ2crKoDsA@vger.kernel.org, AJvYcCWL5nO1BH3AXM0e5+aNro/QC0NUxVOvegKOm8zUI9UJzBc+2YOR0nnizzEZpa0AOL5CDdQVi9OykrR9@vger.kernel.org, AJvYcCXLQuen2hHu3dst0UifhhgkD0aG140W/GL8vwrzYxmXvqpusjjDSssZn316+biEK96Om59rbNfx3GVn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnzl7LOImXY/WQXJuRU9nbBJ4xjeHfq8DKJgxfeBCpq3PhCQ1w
	CaW2syt8hh0chUXYD2iCoR2W+rzVlI/NhfLSZG7RjN5B3K9yDq/YOcU2nubcyikGi/ucxoQSY2v
	+H+J2cGqjZ4WPHecDG5yTxX9eRbE=
X-Google-Smtp-Source: AGHT+IGaxFv21uXx+/xZJU/kjl1OxZbW01D0pVYnfO3CdcXbQ/N3kGxbqbV7+Ze+Pe9bRVYVDyDb9xLbba+Qkot3y1k=
X-Received: by 2002:a17:907:789:b0:a80:f6a9:c311 with SMTP id
 a640c23a62f3a-a93c47e2257mr1167476366b.0.1727637748858; Sun, 29 Sep 2024
 12:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
 <20240923101206.3753-7-antoniu.miclaus@analog.com> <CAMknhBHRfj7d8Uea8vX=t+y+9dqoPABQSzsgNhBMTK-8-f6L7w@mail.gmail.com>
 <20240928183044.0b5ea2e0@jic23-huawei>
In-Reply-To: <20240928183044.0b5ea2e0@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 29 Sep 2024 22:21:52 +0300
Message-ID: <CAHp75VfChXnRsQVA7nQu0L8evqFZrNoCXMq_KEc6_md4EWPyvA@mail.gmail.com>
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nuno Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
	Mike Looijmans <mike.looijmans@topic.nl>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>, 
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 8:30=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

...

> > We have quite a few parts in the pipline right like this one that have
> > per-sample status bits. In the past, these were generally handled with
> > IIO events, but this doesn't really work for these high-speed backends
> > since the data is being piped directly to DMA and we don't look at
> > each sample in the ADC driver. So it would be worthwhile to try to
> > find some general solution here for handling this sort of thing.
>
> We have previously talked about schemes to describe metadata
> alongside channels. I guess maybe it's time to actually look at how
> that works.  I'm not sure dynamic control of that metadata
> is going to be easy to do though or if we even want to
> (as opposed to always on or off for a particular device).

Time for the kernel to return JSON on a per channel basis?

Just saying :-)

--=20
With Best Regards,
Andy Shevchenko

