Return-Path: <linux-pwm+bounces-6007-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A858ABAAD4
	for <lists+linux-pwm@lfdr.de>; Sat, 17 May 2025 17:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E591B60695
	for <lists+linux-pwm@lfdr.de>; Sat, 17 May 2025 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17620127B;
	Sat, 17 May 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JmWYLM61"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1608F4B1E40
	for <linux-pwm@vger.kernel.org>; Sat, 17 May 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747494663; cv=none; b=lznxJxjbOJ1t5oSGA28Jw51Jy3fKAH7dy+IZupoA0sM45PZ/bnbqz2HN08ecqEHTHObnH6JMNZPQkMUkTl5+/oIRQkMl/XdxNs2dByf0W5p8dlyjF0+XBuCy5POWLqNTo/u0GTQ6buQBpfg2CJt4CJENkWh3D5up381RN7TybuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747494663; c=relaxed/simple;
	bh=cosh0zzWHd5H/nIAOnZLFmAAo4F4UNq0R25tBLRsQso=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uL12Pq5kPg7JNTfNRDaXYMNRlM8clit105T/EzO8OeXCOeOmxmniThuS4eGbPW90EcC2PHc/VoMrEoQRi+ypJRiyrruSNsATnD+ddUz4mDw3IQHAiePMohL7UZZ6Ao5Ar0qKCHANbq44KwA3AiVvzK4VlVcRmDU64CLhehkPVBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JmWYLM61; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fbda5a8561so4472577a12.2
        for <linux-pwm@vger.kernel.org>; Sat, 17 May 2025 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747494658; x=1748099458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cosh0zzWHd5H/nIAOnZLFmAAo4F4UNq0R25tBLRsQso=;
        b=JmWYLM61fiiKLzGdT0ntKgBrjZQzeoIjKqM2qLISkb9xFf9AZX815TG2YbqJIJbumu
         LVpuftX9yJDiLBLbkg3v1InHq3JkHh4ti5rqRd9pHbqmmVkVghvrPqaJh1NL8g7TW2mG
         exz57DeL1YzVxlT8DOj62cTXVWovFsw4sOEUaPnu8vd9BnLwF7qyJsfkXFGIVrpaK44U
         omD7QkvYpmb6Z75HB+thDF1KbW6Rggy9kEsIBgZdkRYQnFQ3OsI1HjrgJRCRGkAMz9Ou
         88Dnmh26CO3ZeIYbByQiU/nxV8yNdbPE6d/lJp8fXUXG3pi8tUCbsSgiv+OhSxZFjaK6
         roLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747494658; x=1748099458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cosh0zzWHd5H/nIAOnZLFmAAo4F4UNq0R25tBLRsQso=;
        b=aOKQFGynNzTem/L3U67pY6x01CpmzcJKZ8raTCMnKIVfULENFpLuAUBNaKt9NYVsag
         IO0w8bSd62Jo3KxT1ZgMnGzL7cjchA20YAIvj9A0HBGByotcQKgKFAGlCUJaFJHNV2Yu
         N3hkjNh9jxhVfP03w+uwTSKpiadFGN8aqk1qoxoWtToYE9ORqusUAgZVLSntqOL7O0z0
         CU2BBLJOcLj5ojmYsTLWlqq/1zUcnYLUXeIKpojMLsp8QJ0sOdAAyRbHV1PSDvu7K0Go
         bds+rFAtvxSBQGShjvxKTR4vjsAMqpc7YgK/P1Jd45Re3etkRqOrY44cWp2BOH6yU1Os
         IVUA==
X-Gm-Message-State: AOJu0YygM+RVcTSXZVlAObbj23r0lqjMwt2IQ+2aao9SXgBpp23nTiyY
	L16OX8C3qv73v7u8kD4j2lc09eeYgnZbcxby5XHjawQO9mhSn1Nueb69GfcdZVcZOIsLqxI3Acj
	2x3px
X-Gm-Gg: ASbGncvQ6aYwv5OkU6S5GTbgrjNsiGpEhwbJ/gg9s9xGDOgCZPMZkuEHZgdyfPpYMCE
	5TrWtJqKWhmCkRUixZFiwABQGlHU3BBpF1EhHFYflm1WO/KG5jHwsdM7W/qIV9QZjqYJZl4CMyM
	/Zah8K0qu7+lY7YJKT+o7nmiDrH7Na+LBHl0lTiwHS1ZIp0uvlma64jlYW7Bgx7BkDHKgujGe1H
	S4c2bQlSBxxWII79dZgOVH36GjYVheM/EyM+FQtl2kBuM0eDAVlKMQCTUTp7virOG8eAYR/hVFD
	xbErFb0jQstnZW+OpBflTL7Ibk+lJyffz8xaL542thdhbZoesUQGuGEy
X-Google-Smtp-Source: AGHT+IG2lTTBFROh4j36aLnwCqBo1AGmXlieamJTl03KoMk7faAlxLdn6KUfDmiwkrHS7QehmTt38w==
X-Received: by 2002:a05:6402:2343:b0:5f6:c4ed:e24e with SMTP id 4fb4d7f45d1cf-60090110e2emr7528846a12.27.1747494658062;
        Sat, 17 May 2025 08:10:58 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6016d193ebdsm2476247a12.57.2025.05.17.08.10.57
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 08:10:57 -0700 (PDT)
Date: Sat, 17 May 2025 17:10:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH libpwm] cdev: Make backend compilable without
 <linux/pwm.h>
Message-ID: <zdl2ymgvqxp7ghbo2yutn7en7qyz6lk2ijqpqiy527q5qhvh7w@vsbcqazqazdr>
References: <20250516191855.1354125-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vydsc4rudbj56jm5"
Content-Disposition: inline
In-Reply-To: <20250516191855.1354125-2-u.kleine-koenig@baylibre.com>


--vydsc4rudbj56jm5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH libpwm] cdev: Make backend compilable without
 <linux/pwm.h>
MIME-Version: 1.0

On Fri, May 16, 2025 at 09:18:56PM +0200, Uwe Kleine-K=F6nig wrote:
> That uapi header is quite new and so hardly any system provides it yet.
> So add a local copy and fall back to that to make character device
> support included unconditional.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Also applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git main
=2E

Best regards
Uwe

--vydsc4rudbj56jm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgopv0ACgkQj4D7WH0S
/k6nSwgAj+kC/rLlpZ2Zinatm7JxikSdbUX5nPqhob8uzb9m3JUqN7cV2WPIuR4B
De78qoboQvS9X1KgenV/v5FK09sF57uMxRRYKH1kVN01GX62h+z2vYslvo0Dhp2z
7Y82Q5t1LYHrs9JLOJhvpNNSLDoWhwkeZUHkQB7SzR5MlU3bFHEDY3m0xHtknFT/
l2btCzBhYYe8OZWezTBHFIbJtshh5/UkjbcA7nututAv+7UETAZnJeXzKm+5PqIB
lHde5VTb1PBPekdLGIqgkJE+jawGA2MG5pzefjQRX5Bnc9Hq6970vl8zWiL9Opmt
+oGz6vaCxobOLcpL+MAQVsuDocdl/w==
=kVD2
-----END PGP SIGNATURE-----

--vydsc4rudbj56jm5--

