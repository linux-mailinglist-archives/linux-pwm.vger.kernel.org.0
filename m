Return-Path: <linux-pwm+bounces-7099-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E85BB2C584
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 15:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9823189DAF4
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 13:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA6D341AA0;
	Tue, 19 Aug 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6jwNhRW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85453322741;
	Tue, 19 Aug 2025 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609571; cv=none; b=WOAKETY8XWfx6yGiEaw/4dQgbEW4KTC3YgXlTyFfxD0jKQPfgmHB+ztC9bC70gX2jq8NrTft3WDk/5QKCNzYtftSB2RNBJCJKEEGOnv/YnH1jxtWhNXyWWMC7m4s4Egjvv2xdvLWmNyskTWQYfXaqffTNjbLx9JYrcgGDCoBEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609571; c=relaxed/simple;
	bh=r23hmMjYeFnmQbtG3d+3ohTMfPdmfJrL7/bunmfRuaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVgB2dyYvXLu3BhgjRmiK4LZ9r7IlBfl5xNyo0UbtnhfC5qcZjIEFajd6FQolilyeGamphBYSFmXx4OsAaZBt+r0hAtmgewVlJZFVEGAmgCnyDRWCpVMMaHO3VdUNPWz7rsSYImz0xLWcg7dwFL+simGzp9Etj4bowmRdRtML74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6jwNhRW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323267bc2eeso3759195a91.1;
        Tue, 19 Aug 2025 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755609570; x=1756214370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r23hmMjYeFnmQbtG3d+3ohTMfPdmfJrL7/bunmfRuaM=;
        b=G6jwNhRWzP7TnO5eRjxZTd4eUsxnVKXSCOmr4Y559//KHQ069d85tUZhkneio7Bm16
         fBp37/P5E9835T7uB88VMbK5MJ+z1lZe1wOVzOY3YzUzg5EbA1JanESAoFzMN30LYKVz
         oRAXZmWARqD7hzQGjrvOY7EQh4FMxz6cM3m8opY9UwxUqgfV8mBpwNId4EUhsVf1/WEc
         FAgZZwfO9U98n7s7FGmHcNVkoU7YpOjMDWOeQK2Rk49NT8wRga0Pahzl7kIrB/IGuU4q
         jVVteHQSbaPIIa9ucdbd9f1qg191ufas394P6z+6JgoRx07c+co+1MwDLf1VgJDYrlGh
         s/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609570; x=1756214370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r23hmMjYeFnmQbtG3d+3ohTMfPdmfJrL7/bunmfRuaM=;
        b=gHvVNjZ6w+kHN5vJc/iegUM5uYlmsEAKn8PMV1KIbr+ttHBK62spP2QumJXQpea6JE
         cZosAnR0iJiiKwMqr8J40H/VarjXPKD303uxBkNhbsa+EbjCxEDojGlnajhydvB4XIXr
         Gl2aZZemsfxiR9g6H8Yj/rJrD0/qVymkYw86f4eJOPFzKhXSGlLENdYnGZCgOMgHZ/e/
         gnRpbwEkrtGafPYw51QK1siH2YGgkCE/AbyAWP6DWnwBzmVTxHU1fyNw8mNRiqOqBRoV
         QS8rl8UCzmDTOW9McN9JEDdDxPSe4ZLOP64uR3uK63G777SE/ejRRHk9P9ylMxf4qh0d
         mVjw==
X-Forwarded-Encrypted: i=1; AJvYcCU8wg0oQHZcCYMRsqOc09jF9Q+tnuhlbg/KvmBL6uInY3tHmK0/w3Z/itZryRqU7b/GLS1u8rvi6twJ@vger.kernel.org, AJvYcCUQAAxjC1St7mtpnssd6bdnU6+7MqRD83XjrPxJE0rlInzL4pb6PjmAg8AXSkdMcygbxEmLCHcmvjt4ahE=@vger.kernel.org, AJvYcCWuJILw2JEGpZynnrvt6ckPTuqHbKeQmew1mglrkBhs1dJvdBxTPA7/QEAYyj8CMvN+piqAOmwfR05+RZU=@vger.kernel.org, AJvYcCWxWAC8SE7RP91Kzjw1xnYBc52EXoWpSaZo/8wPYW3DUF7rx3o8MLkN9udeDX4KyG6Pyn+BHlXLO4Mq@vger.kernel.org, AJvYcCXSkim3lErXp0t/B8PlqGVG3XImGHsCN6jo7Xmnfnwz3G5IFF3eAFLORHtZtE2hALbgekIJ4LZjU4df@vger.kernel.org
X-Gm-Message-State: AOJu0YxVXa3jCwAFI2Nb6/q+WGGTaPRTx3PIAMi31J8lD4Dh2X2ZuNwY
	VYVpgnaAkPSi6aHLyMRJhwMw13kJuIfq64/sQjKQqb17dxwPFJ+qiChJmM9DKyn0AMMj5SqNJAl
	Hel7WPYeaMKStziIEvxtSIO9YgRh79A==
X-Gm-Gg: ASbGncs33BXRR6dF3WJtdVtLGok4Zsj2HaGAHP+zmzQ7ve4osmOsjL93TdkvGAKdcaL
	VTT904g7JRbeepHeo4h5zKF/DSW8IC3so955j3lRwMBJtapHYFNlq1jnCAahgfblSITREKMYqZf
	Q6/xoLuRXNk7AhViUSaBreYatwBSvRL9zYJQKa6H+dvVe5laNhh4aLGZ7sxuLpQp/arMBCDxWvc
	iPc3jw=
X-Google-Smtp-Source: AGHT+IEhhIygA1bnMp5OmuLfxqFMwh/55vlg61V7P62U8jCxjgB67lK8mBtooTUSQ4tyZ+w3P2ukeu2oqxwqtea8dJY=
X-Received: by 2002:a17:90b:5103:b0:313:f6fa:5bca with SMTP id
 98e67ed59e1d1-32476afbfbfmr3312885a91.22.1755609569563; Tue, 19 Aug 2025
 06:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com> <564lqfhskoiivxziptyhrkajpblrrnk7nmfe73fzsd6ov2vwlh@n6ydqbrxh2my>
In-Reply-To: <564lqfhskoiivxziptyhrkajpblrrnk7nmfe73fzsd6ov2vwlh@n6ydqbrxh2my>
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Date: Tue, 19 Aug 2025 15:19:17 +0200
X-Gm-Features: Ac12FXyaAV_fr68gP_yU1FNDg6itu2IlLFaD6Hyb0iuATvPfS4x6a8BXCW6M9uY
Message-ID: <CANBuOYoJv5F=4H71fPoWx3MmzSQuKt_p5SPMJx1P=PGwDrEmPA@mail.gmail.com>
Subject: Re: [PATCH 0/8] dt-bindings: Convert TWL4030/6040 family binding to
 DT schema
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	peter.ujfalusi@gmail.com
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, conor+dt@kernel.org, 
	lee@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-usb@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > The following eight patches are included in this series, covering the
> > audio, keypad, power, PWM, and USB sub-modules.
>
> Thanks for doing that.
>
> I think the patches are all orthogonal and can/should be applied by the
> respective subsystem maintainers once they are considered ready?
>

Hello Uwe, Peter, and everyone,

Thank you for the feedback, I am now working on a new v4 patch series
for each subsystem with few improvements and will make sure of their
orthogonality.

While working on this, I had a question about the 'maintainers:' property for
the new YAML bindings. I see from the MAINTAINERS file that Peter Ujfalusi
is the maintainer for the TWL4030 codec driver. I initially marked him as
maintainer for every new twl4030 related binding.

For those new YAML binding files I am creating, should I list only the driver
maintainer (Peter, once he confirms this), or should I add myself as
a co-maintainer since I am authoring these new binding files?

Pinging Peter for his thoughts on this as well.

Thanks again for your guidance.
Jihed

