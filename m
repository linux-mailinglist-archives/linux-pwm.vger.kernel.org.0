Return-Path: <linux-pwm+bounces-5835-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44797AABBB6
	for <lists+linux-pwm@lfdr.de>; Tue,  6 May 2025 09:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07403A9FEB
	for <lists+linux-pwm@lfdr.de>; Tue,  6 May 2025 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706DB289E11;
	Tue,  6 May 2025 05:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQHIw5NZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F682139D2;
	Tue,  6 May 2025 05:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746508270; cv=none; b=tL1cfXN7rQntD8ofA9RlcQtlLx2kwrlc/oduZvtBEwEV9QPMxMz29uZ0mAvkbuph3ItX3/AO6m+CI4su2gYQZt/Uv8KhamDVVF+lczNv2tKWvROjgIM/4WjKLhKQbGJQhJivc5JIuZqnvzUD6wmDkhIqMXVrkCS344RyjJVD6mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746508270; c=relaxed/simple;
	bh=CI4i1B9euLP8x//+FHqQVWisGZ46riW7BOCrO4SVRX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSBT+6BM4mfqJoURJ7OXeuHO1S/qaW11hdtL12wRxbxISQ0zITh7nAuKcmGgBAldriejxgQVL5PwUIq1sYWx4vW/GqpjcqIfr28V7o1ghp7O6D5c+cVq3ezBFEJFeXKtEjKh0ENWIlAufXaYPeav+MG6Kk9EPZ/3WJDhpHqHoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQHIw5NZ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30a93117e1bso113758a91.1;
        Mon, 05 May 2025 22:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746508268; x=1747113068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLeas8Li48TySMUHWqANlPkw8T4tUY9B0p2mUn+Xfr0=;
        b=NQHIw5NZ5GNsOrms1U430wvRKmyknBLF8C7qydH8AlMMUa3xd+YTlbA5BArLs3yMOA
         rEgpXnzXd+/v2RoehM6Xxgp57XM0iuvUv6mKUVQ18PoDH8wEdL3TdalphX5TXk6KGlQw
         D69ZogQ1kcGSdX1uTrhNDJzNdFN+gtG2ZrIHx4U7EbZugl7K2bTP6YN/maoYDLvU8cc8
         y+qLN3k5G+ej86HOeJH3DRZ7RxItzDUpuFQPXrphcE1s/SMfmsG1oQhE1CGb241RQLQc
         BC16u+71mOHaG1Zf9EAXPqNHNQETpiM0riYbvm1sA97GfrlAVi/mdZZnvZVNbBon2+Eb
         Py0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746508268; x=1747113068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLeas8Li48TySMUHWqANlPkw8T4tUY9B0p2mUn+Xfr0=;
        b=BtAftN3Njv05NNR0zQMOZ0BSZ6sdwTFqHt+V+TEeGcL2Lj/idWBNpxUiMwB3pYxMXM
         fAEabEN4ldrYR9cC/KKzSMaAqsIK2vI/Ffb0oV5opYgesPFk2rL7lwMJxwEYIDJ/zJoz
         R5zqy45JauQJKJrCuzN2VijdPDfEwVaAqCaIY73EalJNOCDxr04MOAU3iPqhMaaG2IZH
         GJtUGtes3WZrnRATFu0Ym9M0GADuHFQdtOd7U/2TprPORZSMs3QqoM65fyJ+STVyAykG
         ahQlCb2XnjVUOw6p2HhVfninRD7/Me7FL+UmDBLiQns6Y857FZk8JZrh7p/c/LEyrnX6
         nHLw==
X-Forwarded-Encrypted: i=1; AJvYcCU84lq5IuyLsXnfVZCwFrUSneyvVx2Lnmsff1WI+CafQNrYrz0LkkBomolxdjBiICCCEqBYW2nJ6VVB@vger.kernel.org, AJvYcCUL7UFA0G3wu8PJ3S6AVNCd8GAeSbKa6qcH2Nbw71WNFSxAiBadrluLvEHJe+DgU7m+koUwnMePTGRMrB4=@vger.kernel.org, AJvYcCVN7womjCSAKUgQ8AkdjWXJPgB6CtTbVJ81E0m7mh3gEzU0KbUFey2gQOsxlKRtukid3yQf835aTg1qXWYp@vger.kernel.org, AJvYcCWC2Y8Ps5g2QmCz5csKEJ8i+A0D/orwV+b+JRT47Y86a2X1HyyicPjEA3kx5d4EWp/172uMC6scd8Yupw==@vger.kernel.org, AJvYcCWj7/XQ/NqOk1lSIOqXlwzNUy3y1GXiUnXtb1OqfMjXgHfj97qNASMYWiIORf6MxS6fyxt9dArJxwcr@vger.kernel.org
X-Gm-Message-State: AOJu0YzjNDHHTBEQQFdeTsHfqMz0bURrMipT+lnGFaGzrOl46VaMHOzz
	xWXjXLaLtNtcWGc3dFN9u0qXR5nlfZCYgQdnh8hEJTAUadfa2mrL
X-Gm-Gg: ASbGncuNi4TOD4W9tIwJ36h8yBC/Hd5wmr7slu11Avz1ybdbsJJBZaRci3b71/p8U5t
	voyz0Co3p3DRnBHlKIqxwn/zNzc8599oxd3T0qmIhCth7aTZDJU6QdkoJIGAJxW+LT3vCA5JQKl
	CJyYWwOdlEkWpPzJs4+OI47IMDCvlQLNmKdWZ2Bhh2UeRdgZqkRh3Tvlyx8fECrmp4qCcYdKXXS
	+O6urKteB3ZXgmC4RJZku6qSCzXIpsI1QdJC3ko07MUbPqHwDYiTHEw0LW6owQcKQdorbOUIEGK
	om4QTdNbTgV4xaWg1u+JbVZNV5FxclgKoSndFFe5Cw==
X-Google-Smtp-Source: AGHT+IHM3lDvnqLdoesUo+uJi4M/M2ZwTTwbmZ4orgbHaFGwITXJQOKxmg8xNyy9NcvHWdLssbXY7A==
X-Received: by 2002:a17:90b:3c44:b0:305:5f33:980f with SMTP id 98e67ed59e1d1-30a7f7053d8mr2142527a91.27.1746508267597;
        Mon, 05 May 2025 22:11:07 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:17ab:9e47:29ba:57e6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a347221a9sm12802505a91.1.2025.05.05.22.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 22:11:07 -0700 (PDT)
Date: Mon, 5 May 2025 22:11:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 09/11] input: keyboard: Add support for MAX7360 keypad
Message-ID: <7nuovfjsp7dqklz7khk4biabo22d7qpqqajpcte656vinoft6c@ot6epnbgzgp4>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-9-4e0608d0a7ff@bootlin.com>
 <aBSii0rHox72GM5Y@smile.fi.intel.com>
 <D9LPB49CQJDW.3VMFI0TFGV7K2@bootlin.com>
 <aBTJcQp-wBLJTh-6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBTJcQp-wBLJTh-6@smile.fi.intel.com>

On Fri, May 02, 2025 at 04:32:33PM +0300, Andy Shevchenko wrote:
> On Fri, May 02, 2025 at 03:15:34PM +0200, Mathieu Dubois-Briand wrote:
> > On Fri May 2, 2025 at 12:46 PM CEST, Andy Shevchenko wrote:
> > > On Mon, Apr 28, 2025 at 01:57:27PM +0200, Mathieu Dubois-Briand wrote:
> 
> ...
> 
> > >> +static irqreturn_t max7360_keypad_irq(int irq, void *data)
> > >> +{
> > >> +	struct max7360_keypad *max7360_keypad = data;
> > >> +	struct device *dev = max7360_keypad->input->dev.parent;
> > >> +	unsigned int val;
> > >> +	unsigned int row, col;
> > >> +	unsigned int release;
> > >> +	unsigned int code;
> > >> +	int error;
> > >> +
> > >> +	do {
> > >> +		error = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &val);
> > >> +		if (error) {
> > >> +			dev_err(dev, "Failed to read max7360 FIFO");
> > >> +			return IRQ_NONE;
> > >> +		}
> > >> +
> > >> +		/* FIFO overflow: ignore it and get next event. */
> > >> +		if (val == MAX7360_FIFO_OVERFLOW)
> > >> +			dev_warn(dev, "max7360 FIFO overflow");
> > >
> > > If many events are missing this will flood the logs, perhaps _ratelimited() ?
> > >
> > >> +	} while (val == MAX7360_FIFO_OVERFLOW);
> > >
> > > regmap_read_poll_timeout() ?
> > 
> > OK, I can try something like:
> > 
> > +       error = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &val);
> > +
> > +       /* FIFO overflow: ignore it and get next event. */
> > +       if (!error && (val == MAX7360_FIFO_OVERFLOW)) {
> > +               dev_warn(dev, "max7360 FIFO overflow");
> > +               error = regmap_read_poll_timeout(max7360_keypad->regmap, MAX7360_REG_KEYFIFO,
> > +                                                val, val != MAX7360_FIFO_OVERFLOW, 0, 0);
> > +       }
> > +
> > +       if (error) {
> > +               dev_err(dev, "Failed to read max7360 FIFO");
> > +               return IRQ_NONE;
> > +       }
> 
> Maybe something like this (see also below about timeouts)?
> 
>        error = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &val);
>        if (error) {
>                dev_err(dev, "Failed to read MAX7360 FIFO");
>                return IRQ_NONE;
>        }
> 
>        /* FIFO overflow: ignore it and get next event. */
>        if (val == MAX7360_FIFO_OVERFLOW) {
>                dev_warn(dev, "max7360 FIFO overflow");
>                error = regmap_read_poll_timeout(max7360_keypad->regmap, MAX7360_REG_KEYFIFO,
>                                                 val, val != MAX7360_FIFO_OVERFLOW, 0, 1000);
>                if (error) {
>                        dev_err(dev, "Failed to empty MAX7360 FIFO");
>                        return IRQ_NONE;
>                }
>        }
> 
> > Sleep_us is 0 as we are in the IRQ handler,
> 
> Isn't it under the mutex, so we are fine to have small delays? But in general
> it seems not okay to sleep here. In any case 0 for sleep_us gives an atomic read.

This is in a threaded interrupt, you can sleep all you want.

Thanks.

-- 
Dmitry

