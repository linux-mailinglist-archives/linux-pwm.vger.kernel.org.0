Return-Path: <linux-pwm+bounces-4714-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FA8A1A2F9
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 12:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF05168737
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 11:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFC120E030;
	Thu, 23 Jan 2025 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6zprG0s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920320C48C;
	Thu, 23 Jan 2025 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737631903; cv=none; b=WE52RylKDQr4LcJpaXwHx3eYQKY44DdMAgs1TgWUml2Yy/XG/5rHLZrBeB6oFWqoDtaF62z3lhpO1NFk/tdehrV7v0Q3RaonMmAoXx9ypVDLe1s4yH1UhcQppxOC7OrSfknEuxmv3RrogVFfZ5Cj+0qcFTi0Qdpq63951XvGzKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737631903; c=relaxed/simple;
	bh=sBNOOt/FFzGr4GZIFo0QFOSJGbjO9vXTk9gwpipW51w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTcnyGazdhCJfFoWz6hk7zyfepuDo8Q9QyP678ibZCPQpJl3ByqeVDvwj5uXr6k2gFmCgH7aubc1R3GW/5gOHbz3EssdMiI/GpTDZwJhYmPs4gXUoY+H4KQzbLjK8ag5VRgBBaUJ8j/Hu/LjewMqNGvABia7tbrVHrOoykPUE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6zprG0s; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so1247630a12.1;
        Thu, 23 Jan 2025 03:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737631900; x=1738236700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBNOOt/FFzGr4GZIFo0QFOSJGbjO9vXTk9gwpipW51w=;
        b=U6zprG0skXE4mJgNaaGxFXpWlRr4S01mkYGToS9IEaaUiOIDqFk2rFLgvAPe9swcOt
         JceD3vcNWRjkfkBPsxOrqTKuk/XEfZ2PpbOG/i57aHip6lbxawI1C9LN8CELG8lemV/6
         yBNHk9eUFnkwpHOAYy/cAw8Qf8lux72NCGAtE0hOjy/HgS2NahwdLe/DJulbzE6HzXke
         MCE5Tjq6jYkMF9HGwGjvnd5Ak+IRNMUDX9INtg0viei969Z+cH6ztNtrcNfztvka7vUU
         g8LdetHvT8I0LXRFrTQHiAt9MiW3127eZLUSzDMBS+NGUc1HRUIct02D5ifqPnfxYID7
         L+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737631900; x=1738236700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBNOOt/FFzGr4GZIFo0QFOSJGbjO9vXTk9gwpipW51w=;
        b=IagfObtLOjpjIcYyjk38CuSy2dQHqYjcNEtGtCgNDaX2aImaF1T81avAyIX3dVrZpd
         ovR2dYDcpOx/yW6dFHoYCS4S64XrSI7hyqJoEwxmgA0n1MP0rovOvCP5tfNNRPeXjIMB
         OvcvmUTnLvLy2MQdrx7h2mJnH/magQmTjotPNyVpveUVLd507yfd8ouUIDJM8t9JmyVJ
         VUYeog8MnJ+7UdKTpN9HlnXyzHJ70lGy/3jZQiv4COesdfkDB4MWvA3mJKGkj6Wruvae
         izyplVHzYQuV5FBkkDJLfVgDsf2rQLB8gzKl841gLvXpfmr9ufKMws1nEwltlQ5VeNsP
         RZxg==
X-Forwarded-Encrypted: i=1; AJvYcCVVpq14yTu8E5/8TriL37nwBGhYusIv1Q3013jblWoqX5XbBTZ/7WMa55108MwWf+V7tymRsmQl715D@vger.kernel.org, AJvYcCWxgy2XhMdgMaYWMN2KB8ZGB10/pA4xVkhuW0M09t6SD82AqsAR/pCVG5zx6HVK85AR38Jmo19Z3VuGCNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGYQJnNrb19A0XUYg5cak7K520+Z72g5NS2m/4WKewLCgdfdkQ
	t24MKRNk2c1EaGTSbt+k1g7IIPAJ2vWdbNay8bxaxXuXX5v/esDpZ82W/xHAH5oXTbgQ/WeWKsI
	OHpjCPY3DHz272EEq5NmdyhKUUaBfrXGI
X-Gm-Gg: ASbGnctPB3FcHEYMUsxY2ayCLrzFUl7A8kL1mGBDO6nFwLEnWkyxWiYOwUzSjfHUCYq
	QZpNDYhlsphJ1BtEg5x0oYJEfah2rvIdK6O3YjCYnIz7HwOl7vlD3jNGUHPkQAIqE
X-Google-Smtp-Source: AGHT+IGn2uh/lJCxsZxnCH/kVmQGkqWzetpjQpVBrKjmrNw+IfT71VReeMrEAN9bZwt4Vx7EFTmYT71DZSX3uT6RhQA=
X-Received: by 2002:a05:6402:4416:b0:5d0:d3eb:a78f with SMTP id
 4fb4d7f45d1cf-5db7d0eca61mr63474316a12.0.1737631899367; Thu, 23 Jan 2025
 03:31:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123103939.357160-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20250123103939.357160-2-u.kleine-koenig@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 23 Jan 2025 13:31:03 +0200
X-Gm-Features: AbW1kva_7z6rhV_gwhcXJCLYgktDTLjTqnZXCFb4YGTKT8Klk7JdTblyx_cEkT4
Message-ID: <CAHp75VdxGSxzeS3qGxdGmE2Z_xvDyCX5e+oAE6B23Mas-Ln34w@mail.gmail.com>
Subject: Re: [PATCH] pwm: lpss: Only include <linux/pwm.h> where needed
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 12:39=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Among the three files that include pwm-lpss.h only pwm-lpss.c actually
> needs <linux/pwm.h>. So move the #include statement from the former to
> the latter.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

