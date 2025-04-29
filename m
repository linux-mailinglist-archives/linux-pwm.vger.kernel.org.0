Return-Path: <linux-pwm+bounces-5775-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FADAA3AE5
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 00:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9675F4C70A5
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 22:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E8025A2B3;
	Tue, 29 Apr 2025 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV1UshY8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA1835966;
	Tue, 29 Apr 2025 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964227; cv=none; b=TeA1NtYYgPRaqg0jEKVP/yYRq2Pgu/6PjOyWM90EP4RqxRanzcnp6ouSCVxPYeCO3ObECRQAAYV4z9qLjFQLCo9g/lsyDvTBMdP9tEQeJTapd95UpEAOCdZAok/X28GRv1bHXslrtSuFs6cNtHPb8hBR2knBgUQrF/AA5emAk9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964227; c=relaxed/simple;
	bh=YWFo4xizY9VcrKOaPbSy5kzMkwMTuDcrv3mEuWOPcEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iq5RKv2t38547QoXOL386w4hi5yx4BzZgDfAdSdwc7x5qBRTIMj5ABuDS7hcvqnz9VMrENSLUSgrUp0aepheeLQeTQfsXJsc/IoZjEO6PJ0BOm9HvEXDdjkdC6m2+qGToDzJE8TEjzD0cKW+I22AWwVRXygyG7y3AJ7WAqe1DTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV1UshY8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acbb48bad09so1229928866b.0;
        Tue, 29 Apr 2025 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745964224; x=1746569024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUbpeTZh/O2+70pK3M2d/VVXENkGigx9cnO3sBLqmmk=;
        b=lV1UshY8bP444rx6SdUOVBikfEfPDR2lfpPaLKeJirH3lG4twPtqKvf9JIntZm6NSg
         pt/IUch2lTNQd1vmApBLnOQIq9xHFFpjc9LOgVqIKvptwOS8NeY77t3qKPIcR1cNWSTu
         K3vL5zykSRzoZSY2J3Uod8hyOh5o1E3HYVNOdgAo1yrqltLnQRTK2+8Yk2lI1Gs/5XKU
         2ZWy/G6EZsFwfMnG/rXzxiMcQ7FDwfBd3jx1DlLehu2gGZbWizYV3+VghUQhSm3vxupF
         ZTQKhC8NpzPMnrn00d0m1HgDv0wBc/EM4jPxKUcTAWe8Tl1rBvJeTpjmRmN3lQE7OTwH
         7UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745964224; x=1746569024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUbpeTZh/O2+70pK3M2d/VVXENkGigx9cnO3sBLqmmk=;
        b=AELev5UnjsKSIcl/ZDl/3n+WtC6iBNWAo1IFUawibFK0aB5mstTOdFuSuNTBRS7Z+G
         8Zmq2joL1YPjujd/wbG4g/+s3eppqLoxHInIwqkHIJKD4cfLA6/SSNPs9EJFOkp88F4O
         wGjQYV7naIkAB33XMptfmMaJe9jwUJLCgOfoVvn72TPJPTfs5SWxjb1BWcYa+H4PBEYk
         mmo7USaEz/X52W3vN101nua0iIobdKMXn6Mff/sLsfpAFXqrA0ycn8Exe3iHlFf69WqQ
         HZ6hEUq396ndT1BPKfhDAElAIPjCa4RpLhhe7oaQN9AibNj0NjyKP+UG/NdpkoBW4Qko
         rG0w==
X-Forwarded-Encrypted: i=1; AJvYcCVH3bSXqOjUCl/kWnM258b+d5e+rIKGIBsuP/4blp7YOSVhO6QKGfFZoBDf8yvYjADbuocZdT8vBwXY@vger.kernel.org, AJvYcCVZe5F/EOL9XZnAtW3vQEZlCBnaoref9Q63czw3hnqLOSm156hBFiHrDIFa9NjZ6qAKAn+iPXAsc+hV@vger.kernel.org, AJvYcCWA79nsTiZ5IK+dQQAaS4EO0U8pyOqkmFy5elBOmL5PQGLNlga9CAdPxZmRJGIu014QrVK/VFrQwPDg@vger.kernel.org, AJvYcCXD+kTVNfyUTPP64PzuDjQZnKnyG7bPKVH7XyTDjRzLgtfmOYfla0QDtCh/Sg+16sCfY63/MYnSPfwK@vger.kernel.org, AJvYcCXSlSRXHn0blnxbvdwGHJCSbtZxgM7DsyrJyNnzPQMMS1eCKIUA3XQy6/3ls4PR+sXiu0MJGzl8G/dfxOUy@vger.kernel.org
X-Gm-Message-State: AOJu0YzUh1YdbosR+V4JCrUFypzJV81SQMKnP/kCyfe7+8qz0Fl/Q4L2
	aes9S8E6crmgmMGO0QtFgA8hZC9UDPbPXrYxFoXD9BXyqyK3i1XKFO7eUndUVaSsok5OOLkj+mn
	Ztn9BRrrAWUb3nyHoKPPuCuBTn5Q=
X-Gm-Gg: ASbGnctc2tD5gF/I1QhkDsa4YtEZR+ITk2dRLFCU/4bb6fMGLJXc7Otb+TQEq6VTKyP
	tKX/1S01IjMlVIAiBunCW+2gQkRM2NcGrXAX+NPRaNN9dm/XUV9AidqFMHORFGv461sKWuwXN2R
	lYwnjBF48B7HXeCDAxH7nGI+vsbTXf57oe
X-Google-Smtp-Source: AGHT+IHx3E1TOCQoFjjfqy8I4fVZMMpJ0iKzLAhBBssx5XQ5DV5jGakXTEI7x5pRT2CHPQidhYYFIxXs+JdDfuHgysM=
X-Received: by 2002:a17:907:2d89:b0:ac6:fe8c:e7bb with SMTP id
 a640c23a62f3a-acee25dcd7dmr11755066b.55.1745964223811; Tue, 29 Apr 2025
 15:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-1-638af47e9eb3@analog.com> <aAe6u6NhAsgjaL5_@smile.fi.intel.com>
 <c3i7g273lgvx7rpihzq6r7exxxnglbwrqwfryyz6ciqo52tszf@cvi7pz4bmkvq> <5aa4d76f-6f16-40ae-9dbf-767c63aa0a3d@baylibre.com>
In-Reply-To: <5aa4d76f-6f16-40ae-9dbf-767c63aa0a3d@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Apr 2025 01:03:07 +0300
X-Gm-Features: ATxdqUHBcczVvmBXvRAjBY2yw7dSAwsyZRXLvCYySReQNpkh_kytP2hJPk00epo
Message-ID: <CAHp75VcZM+4Br2-RMKZixEd1=x3_exbWZkEFw1U_NrFtsejkUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] Documentation: ABI: add oversampling frequency in sysfs-bus-iio
To: David Lechner <dlechner@baylibre.com>
Cc: Jorge Marques <gastmaier@gmail.com>, Andy Shevchenko <andy@kernel.org>, 
	Jorge Marques <jorge.marques@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 6:40=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 4/29/25 8:47 AM, Jorge Marques wrote:
> >
> > Hi Andy,
> >
> > I agree with your suggestion, and in this case the appropriate kernel
> > version is 3.10.
> >
> >>
> >>> +What:              /sys/bus/iio/devices/iio:deviceX/oversampling_fre=
quency
> >>> +KernelVersion:     6.15
> >>
> >> Then why don't you put the real version of the first release that has =
it?
> >>
> >>> +Contact:   linux-iio@vger.kernel.org
> >>> +Description:
> >>> +           Some devices have internal clocks for oversampling.
> >>> +           Sets the resulting frequency in Hz to trigger a conversio=
n used by
> >>> +           the oversampling filter.
> >>> +           If the device has a fixed internal clock or is computed b=
ased on
> >>> +           the sampling frequency parameter, the parameter is read o=
nly.
> >>> +
> >>> +What:              /sys/bus/iio/devices/iio:deviceX/oversampling_fre=
quency_available
> >>> +KernelVersion:     6.15
> >>
> >> Ditto.
> >>
> >>> +Contact:   linux-iio@vger.kernel.org
> >>> +Description:
> >>> +           Hardware dependent values supported by the oversampling
> >>> +           frequency.
>
>
> I don't see oversampling_frequency used in any existing driver, so how co=
uld
> it be introduced in kernel 3.10? I think you confuse it with
> events/sampling_frequency.
>
> oversampling_frequency is new and so 6.16 should be correct if Jonathan p=
icks
> this up in the next few weeks, otherwise it will be 6.17.

If this is the case, the whole commit message should be revisited.

--=20
With Best Regards,
Andy Shevchenko

