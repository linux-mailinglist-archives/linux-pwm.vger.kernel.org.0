Return-Path: <linux-pwm+bounces-8424-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N/DCkayymkX/QUAu9opvQ
	(envelope-from <linux-pwm+bounces-8424-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 19:26:30 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 919E035F484
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 19:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AE68301E206
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 17:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAB13D8124;
	Mon, 30 Mar 2026 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V76BZqIs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0E3DC4D0
	for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891488; cv=pass; b=rDSNafGJ61mCSf7IOmLGD2Tpr5y0FCoospZBHRrF0vqKYYOUtmTLCiUqvUFAeFEwQnellXK7tvJwmv6l+/rIq2tVZSLOrE8QHOa6ME5NW4wOofp27hqL0X+41H4/ZU+XEIhVO3CUEAP4hgw/t1Y4eDQ69D92bZfbG446IYujih0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891488; c=relaxed/simple;
	bh=/POCNtVCVgs8Wz8mZ9O1D8ykDMaaTk6zJm6BSwE9+PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1Fk5zImhvYodrxFqXMya5L2g+X7QH5xcLkFaX9s7B+i0bD7bk8E+tMPFP7goXlxANvh4jSAVBPvamS0RqlJiYaALDSCwUqQBsH2ijLEN9eVgVY48LpGs/lakTqcSb8K/S6pwnFkAdpaPVPtQXaUKawspGOA2x8M50UQPVyvvFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V76BZqIs; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so6297347a12.0
        for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 10:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774891486; cv=none;
        d=google.com; s=arc-20240605;
        b=EAE5lQITwv5Q2++88lydnbVpzuapyo7aXuv+5QxLo+UpQjM4jk3vMTmfVV2mITC3LH
         f0OOxG3fpN9VI+XE4neuuk4mAwnHz4zYyh1ulMJC2b9cJqnD4fFKkTE57QPg+KWEXmLr
         S5zXN7S55GZMB7QLlFRwmfzxdHIff7nUTs+bnGe30TVfe+KB7/BfJOb++1mbJzFrw3I2
         t18Y3MPCEPxJ8sOP5FEp5uV325g04kp4AMd/PgjaoHSrSWjDd1XixbstsKtZy6JUwhw8
         U7PczHpzLmu5Ac9aekiHjiumc82m1DBHmVidRFRfune0T+faewsnFt/Q1cvKx9tSJVv0
         Mr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/POCNtVCVgs8Wz8mZ9O1D8ykDMaaTk6zJm6BSwE9+PU=;
        fh=SWc+RtLGtQ0EcpidYTSgnjbYVtiJ2ethYBp3NmiVMjk=;
        b=WM7h/+ZGIdVjwW6ASFV3IAPoFJFqJ9+xeBZCm9gx7KUTRwncpXnQKGDx9LnGwCr1Zk
         ZKJDe7AGUlM61SQFo0ZqQXm/iO1EiARidZYU00XthXXhaMRpaORmk4ikanHHMzoDEpvO
         DeQ79y2toDzABjLdsBjlMaLirEoj0eM8VLbu8tPSXhIbqukxWf8LknY350+Klk8lA1gt
         hI/lFzl7lAAJjN7npmaRSSH5H7yD+gvRH9Bs0zwBE2NYXWOM7sBqOQ2vWC5gxshmQ1F+
         MSzF2Bb0RADx67IBY7NUfEcfjtZVeA+SHkIvqOcQEMFTNHdD2y97OTgAwrbmdMO5am3S
         L0yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774891486; x=1775496286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/POCNtVCVgs8Wz8mZ9O1D8ykDMaaTk6zJm6BSwE9+PU=;
        b=V76BZqIsg6SY28n+CDDu+IH++PLSb8MJSlRIvY02cnLUWXpaxB91LN/qlH3xzlIxCx
         OJpm0KiBuf6pIWl4hS1tBcqhmkha9q0QN7jpVlN/RWZSajGpxmqtZstQppDr8zTLHfCl
         7/3yLIORDyGDv/FwB7cjm/RynB6KgTd3CbCbcKooE15JDQcnwXYC3TG/cD+TSmFNry9y
         qase5dwhuuHQDJ75vNqql1kmgBxzGIcszCChHk74hP53Qdi5sFznMywjfIRhJmz89xoa
         FPIC0Py+qZ9XjashK4KXSbxEdCIEca9UEaypsvN6Gb+8PtPdnCYX4WzuDT0B1re+KOEK
         PpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774891486; x=1775496286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/POCNtVCVgs8Wz8mZ9O1D8ykDMaaTk6zJm6BSwE9+PU=;
        b=FRimM6Hrc4s6mdEIziZZ78E/KAaliLaDeFjaZGmB6mDJU8VSIJe7DsP3C0NzgT1tAo
         OE0piMKdqi4zB0EzF0fw6ZTjH0oM0zLGAX/jGkddM5uGXiraGvq/pPaksAvPrjlH6aLD
         rxZfm4jsRFjWkkly1rPWqp6PitgU319RBjiQW4awXJPVn6ncgTgarbj3DLMhLhqQHRYB
         Mivc0MNnCRNm68jnq+F1PApABk9zR7C7IsPXFInvjWFtlgaSplXVoZrFDzMY1usiy0HC
         KNuVGPRFgTees7yQV3u7kuIfxeRFSz6z2pITrpaE6Q2Cl4iNOt0G9rLe7HkDsNAleG9b
         vGeA==
X-Forwarded-Encrypted: i=1; AJvYcCWSJn59yoceFZ6PC1sthfapt3oL9uxiVHCy2YCzYcDjoMdpHTqOV2qQI5RI+B90VItUnVSVNf63RFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxtUBgezImWa39WGsNMAUgGdkyHpzmx6qefl7qpkAJro6fLHw
	LQ0+RHSbcYFQ7Rvg3FofL3L++amYnPHL9Z1oH023SLsnnvVAG2NBV5lPmi75FKZvC/9MqdDXsIz
	AqyegRgf/ffl7p3RN3CKeoe5oTGyr5jY=
X-Gm-Gg: ATEYQzzzzfO7EGf94o4oXDemucR0PKZ2GGTAGmhgjVcsRHKD+/8MW8nYtA0Kt7pi1WE
	Aq17KXSeU39dgNwdy9CbbwFWUb6SuEs7LjchjbOv6/Eu5CO6i36sl+GiWbKinqASGqgMhsGTfU6
	knUiZHrDwVxKChMCOByh4Zga0jxm6u3DNqlCXyOej0cOgFtWEnw0rOMdyZL9GwVOedTgnyifHg1
	smMXJMM/0i4LIA7tb2MWQoowAJg7mBSXJ+VIoQHoDVWZ1H/3dUHJyBUejrkWo19f/wx/Ybc4bbT
	tC8jt43/E9KcNZSDNDw52inGnCvx28efZ3D1TAx8BIr7fHZf05dbqUtNJPU8XBBang+E8DtzSSz
	Y/pFrKl0=
X-Received: by 2002:a17:907:9626:b0:b97:554:f12e with SMTP id
 a640c23a62f3a-b9b50350860mr690721166b.14.1774891485468; Mon, 30 Mar 2026
 10:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com>
 <20260327-ad4692-multichannel-sar-adc-driver-v5-2-11f789de47b8@analog.com>
 <acZrthJYQX-h_9p5@ashevche-desk.local> <LV9PR03MB84143540CE505514E1CD84B4F752A@LV9PR03MB8414.namprd03.prod.outlook.com>
In-Reply-To: <LV9PR03MB84143540CE505514E1CD84B4F752A@LV9PR03MB8414.namprd03.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 30 Mar 2026 20:24:09 +0300
X-Gm-Features: AQROBzDi52qTqIm1Vf3lVJqwmlc9iA41VGN7nD3k385cLEOQCXsLlg-VEZ4M7zs
Message-ID: <CAHp75VcUCM8aeUpNaFEXnS+Cm08Mq5j+Qp2gYqWP9vCO+9CtQA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] iio: adc: ad4691: add initial driver for AD4691 family
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8424-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andyshevchenko@gmail.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 919E035F484
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 5:20=E2=80=AFPM Sabau, Radu bogdan
<Radu.Sabau@analog.com> wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Friday, March 27, 2026 1:36 PM
> > To: Sabau, Radu bogdan <Radu.Sabau@analog.com>

...

> > > +#include <linux/bitfield.h>
> > > +#include <linux/bitops.h>
> > > +#include <linux/cleanup.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> >
> > Hmm... Is it used? Or perhaps you need only
> > dev_printk.h
> > device/devres.h
> > ?

> I have checked this out and it seems device.h doesn't actually need
> to be included anyway since spi.h directly includes device.h, and since
> this is a SPI driver that's never going away, it's covered. Will drop it!

No, this is the wrong justification. IWYU principle is about exact
match between what is used and included in a file (module). spi.h is
not dev_*() provider and may not be considered for that.

--=20
With Best Regards,
Andy Shevchenko

