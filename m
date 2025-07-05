Return-Path: <linux-pwm+bounces-6734-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB830AF9ECE
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Jul 2025 09:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3818C7B8BD3
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Jul 2025 07:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3F8229B38;
	Sat,  5 Jul 2025 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QGUj4lxl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A59D26CE21
	for <linux-pwm@vger.kernel.org>; Sat,  5 Jul 2025 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751700798; cv=none; b=WIest1hPBOsufRU7Vf515DudzUdbgXy9pvzrgplkXYPYsSrOmwerkrj5u5IIRcbDPwihLJtHteUpfMzfcLqZAlIK8jAcTnJ+T7TJaEBthIklOJwuNmEi28nWdNV7R+bewtcIHa/B+Kd9n6dGi/wQC3QRb/FWsfIaNxgljFoDN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751700798; c=relaxed/simple;
	bh=x5yuYRH37ghBU8pTK2XsWFxaR11sE/Kxxbwe7u4z3qM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2LZECojIvCkBph9YwMuy+t86j5K/tV+lgD+F0++ZHaoNLf5XfZaWlzty+HZhUpYu/typza9CNUS0SS2i0HvFjgSA4KQeOVQJiZHjyZFMTTo8TQ6xM9E9MMgYUR1paePMHP2siwwT8fx2Jf0xCYiBBZjpEg/6n5Qkl8Olwd4VQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QGUj4lxl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0dad3a179so247237366b.1
        for <linux-pwm@vger.kernel.org>; Sat, 05 Jul 2025 00:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751700793; x=1752305593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5yuYRH37ghBU8pTK2XsWFxaR11sE/Kxxbwe7u4z3qM=;
        b=QGUj4lxlT1KlvqOQMcHIGzgJi9n5CozbqESk7zOoB0hcioWPm0vPDQW3n/YYc2Pm90
         9lifASBksRidHE+AXCDqbtHIZPLl48fkeOK1XXm5kK1zEpGac3eqpbw/0YfZn5I7FyIg
         ISGHeVQ99C+UikUi0wdtJfa3tRsaYyQGAMM4ic5HqN6G+niVOI8mydqEFqmVkPfOCluB
         oA9rFfVfp9rsYkTBiXU22eBIUxIxjoGH7IXXSjYi/FdgNNUvMns2CFhEYt3hStBQEB2B
         DB89Ko2TPivTLu3awZ0IoRKeQqjOhzU/UiwrWXnoiXfXnSI0bV4lQYMlFgZ11IN0atKP
         KITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751700793; x=1752305593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5yuYRH37ghBU8pTK2XsWFxaR11sE/Kxxbwe7u4z3qM=;
        b=TgTNxO62J2g2sSsmcAxLr5XhW+Ws81O8wTNBsVK7GanSfUezCs4gBj75fhuGhlu4tC
         bBuoDJQueOOBtXVFcbwXyUQ97cLYLNTed6TJoR7CvZoT9x7dZrtNDEI9cD1tk4itQpdu
         upWu5lAsLNMANYKQJgGxadpD4a9O81BiIBt+XxNSoMzYM750Awh6bHYA+DjXlbWG4EI5
         ZherqCsb04ofbxX4QYNaW9sI2gryve3VVMo+vD3976AaYbXz7e2LOYZmCPxP32HDL5wJ
         a+hidiD5PkrZ8FCppivGjxEE0d8/aPWudwUVHsMF1SttOPhKdKduz4WVG1ppUoDCV8a7
         xhJA==
X-Gm-Message-State: AOJu0YytmEpv2rtfcaU91caao9Hrg3J6TOi0Tvbfl0/klHNIC01nKdyR
	vCkOYZr6I8NC5yyqD+ppCebz7wL/zHKijeld7zi7/Jhp+j8XhdVZ+7iVQWHBI70AvvV+sMRQan4
	ZF4Lk
X-Gm-Gg: ASbGncsiQgB7dtk0Z+ru8KRx3glHYLBG8LHFp2eGwbEUBoxqEKx8nEYd+/lPC3HVy1w
	q0zVTlaxUYNYBhsNn+PbXvGtl8s2sPhN29ghzPDqP+sDFgWkcOCUh8hFJpftbRnM2qe6XhqSxLa
	Za0cMDbLisCgwx/vqPFL7pU5qP6IzLPvso1vRzxm42hBUKv9D0K+YRgKsqm0VcSa0aP9zUo/w60
	KIOPYLHlKJrHUoaz0hlQ8euehO3dvLQ+hl3n7XRvZiSy3PwM1UrGDyD3dYBo4fqn3YDbYDXJ8cj
	lNWh4UiNIMU3iSgdpAl1H5orSJhLwgCUEZRI5/8GtCzWaU3FmigB1ovcvbgAvUmD6Vkaf/KHaWb
	ULg==
X-Google-Smtp-Source: AGHT+IG0GC8APjrC7g1L5wEujc1YmCDBjskj5fAwS1MbCGzGC/KNlw70eE14z0471LK+g23JmEa0EA==
X-Received: by 2002:a17:907:3d92:b0:ae3:bd96:78cd with SMTP id a640c23a62f3a-ae41079de60mr147021166b.7.1751700793006;
        Sat, 05 Jul 2025 00:33:13 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f692f555sm306487666b.60.2025.07.05.00.33.11
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 00:33:12 -0700 (PDT)
Date: Sat, 5 Jul 2025 09:33:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Fix invalid state detection
Message-ID: <hdsucdoudact6exdlqblpswsf47okjudis47qiirgnmt3pjzmv@nlgoac5mxwij>
References: <20250704172416.626433-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mhqgoxpmzllbehju"
Content-Disposition: inline
In-Reply-To: <20250704172416.626433-2-u.kleine-koenig@baylibre.com>


--mhqgoxpmzllbehju
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Fix invalid state detection
MIME-Version: 1.0

Hello,

On Fri, Jul 04, 2025 at 07:24:17PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Commit 9dd42d019e63 ("pwm: Allow pwm state transitions from an invalid
> state") intended to allow some state transitions that were not allowed
> before. The idea is sane and back then I also got the code comment
> right, but the check for enabled is bogus. This resulted in state
> transitions for enabled states to be allowed to have invalid duty/period
> settings and thus it can happen that low-level drivers get requests for
> invalid states=F0=9F=99=84.
>=20
> Invert the check to allow state transitions for disabled states only.
>=20
> Fixes: 9dd42d019e63 ("pwm: Allow pwm state transitions from an invalid st=
ate")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

while I'm quite sure this patch is fine, I still wonder that nobody
reported that problem since v6.11-rc1. So either people participate even
less in mainline development than I thought, they are still stuck with
older kernel versions or don't use /sys/class/pwm as much as I
anticipate. =F0=9F=A4=B7

I applied it at the bottom of my for-next branch[1] with the intention
to send it to Linus for -rc6 when it was in next for a few days. I'm
still accepting acks and reviews.

Best regards
Uwe

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/=
for-next

--mhqgoxpmzllbehju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmho1TIACgkQj4D7WH0S
/k7EwAgAnHqKvEYRCVjhb9UvNlP+Geo4gLu0NLH6n7PEMCRSkeAB0i5FTgwld2S0
xqqcsrXx6+wmhhokT0R6BfmuXXXfmgF6VDp+zk4K0amKtvxsDLQeY+LN4NM0sMUC
3rnO6V1x/awcBWFHdWSKINdgq2r5orFqfyGXg+svvAx5c9kzKM/L1zyJfUQJzITq
H3a/SvbF0t15U1FOJkEkO9Ka0Gbvga9Y7uGpHWS+4yiZb8eR9wRnMcj6AwnmlwWZ
fHu90Lhhnis5OzRnDsufmtNv8YKhL6wPQlOb4H1A1uyAyKVnFdtFkFuXzucVf7xw
82uw+5t+jJNG4GqH3ulvvG5hknMrlw==
=G11s
-----END PGP SIGNATURE-----

--mhqgoxpmzllbehju--

