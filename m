Return-Path: <linux-pwm+bounces-1681-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C86286F0FB
	for <lists+linux-pwm@lfdr.de>; Sat,  2 Mar 2024 16:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336A11F217DE
	for <lists+linux-pwm@lfdr.de>; Sat,  2 Mar 2024 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318871B5B1;
	Sat,  2 Mar 2024 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vM8rwEgN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7BF18627
	for <linux-pwm@vger.kernel.org>; Sat,  2 Mar 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709394753; cv=none; b=M8bMGfHqj6aUr/DMRnPGpr2yc2pAAmiU0qSd89kNX3lbSQPG8/6hH4Yo71XiqhUF2mD9SUjq9JMUhBbbw7d+Jt3ksJVAswnpZnVeVe7l4I5uCQnN4o7VPyyLY2UXm9d0eUIbD39GiNynzWU84RmOyU3Bom25ehNf4e9cnxxLD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709394753; c=relaxed/simple;
	bh=IpeQuxZYHbOib0UXMdpmSgRLjR8MvxoaSxSpZYZToPE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Snd3XceErv3VHjm42Qo1/UjUvNiDJDxRZNxGD2FGB7utEC62oEdyA6pfSzuf1wY1jBpPtbK0xNLTXUuVXEN4ki4JvdTEhJtiDNxTZwHKZwugO3YAOooXqnxa+IHEyim9sbuHy+QF0OZICGl5Y+IGeJIY6bxTNpv4qZf2Xv/0dtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vM8rwEgN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412d5727ca8so3371885e9.1
        for <linux-pwm@vger.kernel.org>; Sat, 02 Mar 2024 07:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709394748; x=1709999548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFHn5+gTrYvZdU2UMo/5Uu0slaoxEdGH237gIhxi8Fk=;
        b=vM8rwEgNt86TgO93LZO8zpZ26DtyGOWECruz/CQ5hcynxeX/kKPL0C1+E4se/yGGH3
         eKswlZSk+eq5N5NcBmR349G4cvIscSztS1QM11ZmMm8GSrBHJj9F3nMxDbV1LpKKNVPl
         4YmGtOzA8k4x/yuLLij1ngC1fq6PHGOZLc1NhCMNnepvsrmezHeyCbPrlUnBhM5yDyDZ
         TQiMXjVkPpxFS0O54cvmZs/Gi8MBHlfOUfi0OeYipBMPsP9BJaq6SZ9tfE/OuMShV1tg
         WX1bO0m8UEEP54bEXS67GQ+hgeTINRCOvjnCO8bGPFxbfBlJCCnYqXIU6TvYfhI1CfQS
         Mk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709394748; x=1709999548;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HFHn5+gTrYvZdU2UMo/5Uu0slaoxEdGH237gIhxi8Fk=;
        b=gADzOXT1KdY9OoWgGxCzVQKo7ntBfq6Q/5umFAPCjQwyqQ8fgk/a2CoTPCCTWJ1Xl/
         PfSlfnXYDS5PgVttZETFGeE8WPk7tloCEMcyWqJd9KVykoXBn355uArN4hleUolrDKA+
         14nny64sj6lDoLcArYp8C0OKvkomvZDJveaVsgrR9QQJPbHHMo/GDUszW5smrT+ZAUkg
         NyuEAV904/Wh+DwiEqhO0FhIsxyHSRX3T4rcL+5eaFIG1l4icy/kMahNRQXToArV0++M
         5b5xF1miEpALXkZMHPe5VYtEypCxZGpiiDK19lPkiIa/gXwI8qWKa3CT2M6Berjy920Q
         7Fdg==
X-Forwarded-Encrypted: i=1; AJvYcCVHonXHZQ8H1QAlVcxcW8gRP+pVpTAZum+jWa2NTLeoq/FVeCbgS2YD6mh7gPDqyxhB6vKBAxlY0Bp5uzlfCCTOXqIezWvmDPoo
X-Gm-Message-State: AOJu0YxmmjTPX2hTSmdGn9LJHjj6x9PhUcPDvgViNQsiBmScSbxpJTiG
	Zo51gb2v3zt8tmC/2XTI/ti0zmC7zju9MFLqboW18fajFKyIShLKzbjXlxLGWmU=
X-Google-Smtp-Source: AGHT+IHPEsKg9YL345VNJehawUEGJqX6jI1a45uLPxbSI3cJXqB9wbFooKxQnCv4HflprTmT7kTmXA==
X-Received: by 2002:a05:600c:4f44:b0:412:a5ed:bb57 with SMTP id m4-20020a05600c4f4400b00412a5edbb57mr4177808wmq.31.1709394747993;
        Sat, 02 Mar 2024 07:52:27 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:a62b:dc91:b659:dbf5])
        by smtp.gmail.com with ESMTPSA id d22-20020a05600c34d600b00412d6357945sm2015404wmq.27.2024.03.02.07.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 07:52:27 -0800 (PST)
References: <20240221151154.26452-1-jbrunet@baylibre.com>
 <b6jyherdfnehu3xrg6ulkxlcfknfej6ali2om27d7rjmwncwxz@3wrtx6sv4xm7>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, JunYi Zhao
 <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v5 0/5] pwm: meson: dt-bindings fixup
Date: Sat, 02 Mar 2024 16:50:11 +0100
In-reply-to: <b6jyherdfnehu3xrg6ulkxlcfknfej6ali2om27d7rjmwncwxz@3wrtx6sv4xm7>
Message-ID: <1jsf18skat.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Sat 02 Mar 2024 at 11:04, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutr=
onix.de> wrote:

> [[PGP Signed Part:Undecided]]
> Hello Jerome,
>
> On Wed, Feb 21, 2024 at 04:11:46PM +0100, Jerome Brunet wrote:
>> Jerome Brunet (5):
>>   dt-bindings: pwm: amlogic: fix s4 bindings
>>   dt-bindings: pwm: amlogic: Add a new binding for meson8 pwm types
>>   pwm: meson: generalize 4 inputs clock on meson8 pwm type
>>   pwm: meson: don't carry internal clock elements around
>>   pwm: meson: add generic compatible for meson8 to sm1
>
> I applied patches #1 to #3. This doesn't mean #4 and #5 are bad, just
> that I need some more time for review.

No worries. The change in those, especially #5, are pretty simple but
the diff are indeed hard to read :/

>
> Best regards
> Uwe


--=20
Jerome

