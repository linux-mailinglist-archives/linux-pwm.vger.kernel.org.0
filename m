Return-Path: <linux-pwm+bounces-3902-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5889B0D8D
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 20:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1EF286F26
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 18:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB06120BB49;
	Fri, 25 Oct 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmUlchIc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80189185E50;
	Fri, 25 Oct 2024 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881646; cv=none; b=Ed5awnu1NhkX9URuuMUW/6qU2ysMCntK+QWU85QVkJu2zslEg/OsjXuiwrGJkc2CakNyoirj8JoGmoPfTrDSRq2qdu8x/68cahoGwg4PhwtZa2holVyL6lisNZFuyLCpCXXJqCnvWRCSG8vdv1294aerNuCFTiTxy3jOpyXmpHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881646; c=relaxed/simple;
	bh=JRxNUr5yui2gNVAeX4FE/a5Z8KBgsyO2L2DGHu/TKtU=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=J4sBl3IhfUNIvQS8LUEBhFX2jMXVPrkCR9mL/esmXmQB6DFZvtxCAL3OKT++IKN7ttJ9Klw8jKM6uqpmZFl5FQ6+xnTaSOvL9DvwN/4H0GH32fo274mVXvnn9lfmdynyFtO3HzrHvHjskW2P2bEUxLzpo78iM4pPyxntUAui4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmUlchIc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d462c91a9so1598331f8f.2;
        Fri, 25 Oct 2024 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729881643; x=1730486443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:message-id:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRxNUr5yui2gNVAeX4FE/a5Z8KBgsyO2L2DGHu/TKtU=;
        b=PmUlchIchkKzpGCZm2vPQcINgkMTki8G8xL4aQVHV4lIKyUHIblgMKFC0HQuBdh4w2
         md1esL0R77wspbiz0v57LTCcdpBYluHBS14BIWj2sy2I6oIvF+s8mg9YGiVHdgqoSOqt
         HyN6bBLG0Ph5VGL6XYTrKULSx6ICVVkSszKOD3iyErVeCQncF3ZbYEnEVXFPHTG4+Wt2
         4zqzozTmcQeqd+bCzSBWZ/Qa0IdOzkbnRtNQsTaY2n8BxZMYX/+hklToscp8QpeTdHNv
         uzLRulQS9uKVY51SZfIu9tuUQoXdSwUyjbj8h0ZoNFSmm3LQn44enhMkGkF2dahV3R99
         Rrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881643; x=1730486443;
        h=content-transfer-encoding:mime-version:subject:message-id:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRxNUr5yui2gNVAeX4FE/a5Z8KBgsyO2L2DGHu/TKtU=;
        b=xRWs4UwOraFmkorxze2F6cwl07h2MkwqRa9KJHozVsZy1BtehlYRua0pCaZmH7aFfU
         KDmPvZvl00r/U1YVU2Vs+hFWurZtnKUDZgGvWL7USy59u2cXUgOtv+TzgcQX6LRpf4sh
         FZqIcPox0RsVGjKvLcQghJ2pbtiJq1hG0lT0gxFPQI26FnAQNWjrFgIAiKStGWg3CYEh
         dr/tuaA8qJRdfqcktmtMYdxiWxjU7rJG3CtZG78PC72qxIexPXFlyeSO4zG2N77T3NMD
         0o1pSxnv1UadjN9UbkJHUPWmg/kkw/reJ+C13CpHNZgOZAkspR+JjHU7hL9pNwA9URDL
         u1gA==
X-Forwarded-Encrypted: i=1; AJvYcCU80Prdd9iHJTthnpNQfiQRK7iCfZ5uPMPnmLn2OPP6ueHPWP0Kk6Idd1Z8UYYDMRapCWXr8rphKs8j@vger.kernel.org, AJvYcCVBOlO4ZrpibAy0Rt2/xAi4vorXfSA5FaN0M/S0h5JXA9i/YKMtaariCKYKY0Yt9zXAyvKBdbYSAPWV@vger.kernel.org, AJvYcCX+OQET6fwLnlBNoiy4KBIronzbq1DE7HKfcwBfV0kCgQEL/TLgjlYC1WHKTZu4J65ss4S2ryq3qQ3c@vger.kernel.org, AJvYcCXCILfq2rWi4HxBw6dFBdbDG431pGcR+dE9mP87D9s0YwlXqMdLxcfUA45VnXp95pJgZaP8ACA/PBNN@vger.kernel.org, AJvYcCXqn17Q0wNCYjQaaXtWfuSDiiE8TMB+phzRXrzjDrOnxdWwCUbPjAGT/BhAsXBsMMEZIn1DCW1Cik04+Qft@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdmgqyNNXaaRR0jmeL0/ipbdieoA6uYYx+PuMMD+qc0NbpXkP
	Ono62HUdZiLJV7rrlw9W9dOPu3IyPKATuimMjT5BGBeBrp4SfpH99slHQj/jEb1kcqtt
X-Google-Smtp-Source: AGHT+IGS6rcHOlbTprJsbT/HrRycQKHd080NuZIR69soUsvtun0u2f/I9JB4hvq+jJZoGz6PjNSYZQ==
X-Received: by 2002:a5d:4311:0:b0:374:c17a:55b5 with SMTP id ffacd0b85a97d-3806111a1bemr275137f8f.14.1729881642551;
        Fri, 25 Oct 2024 11:40:42 -0700 (PDT)
Received: from [127.0.0.1] (aftr-62-216-210-211.dynamic.mnet-online.de. [62.216.210.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70c91sm2193563f8f.85.2024.10.25.11.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:40:42 -0700 (PDT)
Date: Fri, 25 Oct 2024 20:40:42 +0200 (GMT+02:00)
From: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Message-ID: <dc52cda0-47d9-4cbf-a68e-0af304edc32e@gmail.com>
Subject: Re: [PATCH RFC v4 11/15] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_ext2()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <dc52cda0-47d9-4cbf-a68e-0af304edc32e@gmail.com>

Oct 25, 2024 18:42:02 David Lechner <dlechner@baylibre.com>:

> On 10/25/24 8:24 AM, Nuno S=C3=A1 wrote:
>> I still need to look better at this but I do have one though already=20
>> :)
>>
>> On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
>>> Add a new devm_iio_dmaengine_buffer_setup_ext2() function to handle
>>> cases where the DMA channel is managed by the caller rather than=20
>>> being
>>> requested and released by the iio_dmaengine module.
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> ---
>>>
>>> v4 changes:
>>> * This replaces "iio: buffer-dmaengine: generalize requesting DMA=20
>>> channel"
>>> ---
>
> ...
>
>>> @@ -282,12 +281,38 @@ void iio_dmaengine_buffer_free(struct=20
>>> iio_buffer *buffer)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_buffer_to_dmaengine_buff=
er(buffer);
>>> =C2=A0
>>> =C2=A0=C2=A0=C2=A0 iio_dma_buffer_exit(&dmaengine_buffer->queue);
>>> -=C2=A0=C2=A0 dma_release_channel(dmaengine_buffer->chan);
>>> -
>>> =C2=A0=C2=A0=C2=A0 iio_buffer_put(buffer);
>>> +
>>> +=C2=A0=C2=A0 if (dmaengine_buffer->owns_chan)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_release_channel(dmaengine_buf=
fer->chan);
>>
>> Not sure if I agree much with this owns_chan flag. The way I see it,=20
>> we should always
>> handover the lifetime of the DMA channel to the IIO DMA framework.=20
>> Note that even the
>> device you pass in for both requesting the channel of the spi_offload=C2=
=A0=20
>> and for
>> setting up the DMA buffer is the same (and i suspect it will always=20
>> be) so I would
>> not go with the trouble. And with this assumption we could simplify a=20
>> bit more the
>> spi implementation.
>
> I tried something like this in v3 but Jonathan didn't seem to like it.
>
> https://lore.kernel.org/all/20240727144303.4a8604cb@jic23-huawei/
>
>>
>> And not even related but I even suspect the current implementation=20
>> could be
>> problematic. Basically I'm suspecting that the lifetime of the DMA=20
>> channel should be
>> attached to the lifetime of the iio_buffer. IOW, we should only=20
>> release the channel
>> in iio_dmaengine_buffer_release() - in which case the current=20
>> implementation with the
>> spi_offload would also be buggy.
>
> The buffer can outlive the iio device driver that created the buffer?

Yes, it can as the IIO device itself. In case a userspace app has an open=
=20
FD for the buffer chardev, we get a reference that is only released when=20
the FD is closed (which can outlive the device behind bound to its=20
driver). That is why we nullify indio_dev->info and check for it on the=20
read() and write() fops.

FWIW, I raised concerns about this in the past (as we don't have any lock=
=20
in those paths) but Jonathan rightfully wanted to see a real race. And I=20
was too lazy to try and reproduce one but I'm still fairly sure we have=20
theoretical (at least) races in those paths. And one of them could be (I=20
think) concurrently hitting a DMA submit block while the device is being=20
unbound. In that case the DMA chan would be already released and we could=
=20
still try to initiate a transfer. I did not check if that would crash or=20
something but it should still not happen.

- Nuno S=C3=A1

