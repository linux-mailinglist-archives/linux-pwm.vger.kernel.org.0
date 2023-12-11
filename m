Return-Path: <linux-pwm+bounces-499-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829BF80C6C6
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 11:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F841C20FC6
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBDA347B0;
	Mon, 11 Dec 2023 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2zKXG05"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EEED7
	for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2023 02:36:49 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-551437d5344so562400a12.1
        for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2023 02:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702291007; x=1702895807; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txne6UGAQxkw9K0AjsDxhsfFBXaKFL7L2cRE8JycCrA=;
        b=h2zKXG05dl3gRwkbQ8rQQ6PxPYxH3EQ3NmG90eru3RxBGcZRd4jOXKiofKU2lsmcqV
         AwUtOTlbEX4zbkmep1HbwKgnVf4xpMBDhTmyL9N83u8gsX6nSVArqBs23wMkKGHMWE4+
         n7BUBsmBjLW5FNYNQREPXNa1ITVDTf75b4hDRYUDY0DfVxuY9ixwUBuEtUM4ao0oD5fz
         lWpd2sxMqxgQtKk28WecjKI4jMN8dSP1MALlbjF66dxWQnxzaKnVhQX9BX4JJ/n/u9Xy
         OhHsWoaR7RIyr6LcRSs3iDfdjHhEqY6vpEaZGIc9yQJVAKhIFQCN4VYTWyXvH9GP8tOC
         v5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291007; x=1702895807;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txne6UGAQxkw9K0AjsDxhsfFBXaKFL7L2cRE8JycCrA=;
        b=esNrZ7UPmozd2voSOkKKt2VVAvsYCxmrosaL8JX0dUo7BnQdorTv+EVbWpPho9JA2T
         gRNu3KteI3B3/B553pigpSeqr7km8zWtMtahv+t1wNSzUJm/T+qT04wlR9p/f6spRHce
         KbCxXb9LG3zWNFsy67cGh+gPqwDyyJiv+vKj0I1HdXBRrEjr24M09qersl4/McaneK9v
         LC9VfZb+qkBAfrBWTl4Tn9yQFMcBP9bP6US+LLSF931nYn55ud33rFIDuBOVGL7wZShV
         E5E1rvHI1i2OjXEHKaxJr0bnucYEsJZuPiwaXsiVhpntm5wcZf30bGA9KZnBEsRbsLKg
         ARow==
X-Gm-Message-State: AOJu0YxAlal57CvDoMk+Cme/v1GMiTv1/dhJh7RgEr/cAXjCcgCGpJ24
	e0mx0BNgZIsvYoR3KemAWjw=
X-Google-Smtp-Source: AGHT+IEvf3ni7Cfsa3+2K5aC+QwFJNA7YqpnwY9KvsdnQCmX/GGyxTS9NbTu1HpaOMnc+mRCNMxr0Q==
X-Received: by 2002:a50:8a9d:0:b0:54c:f342:ea32 with SMTP id j29-20020a508a9d000000b0054cf342ea32mr2687996edj.76.1702291006865;
        Mon, 11 Dec 2023 02:36:46 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id co7-20020a0564020c0700b0054caf3f8b2esm3516443edb.96.2023.12.11.02.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:36:46 -0800 (PST)
Date: Mon, 11 Dec 2023 11:36:44 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel@pengutronix.de,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [GIT PULL] pwm fixes for 6.7-rc5
Message-ID: <ZXbmPLlc3dJ9TyVx@orome.fritz.box>
References: <20231208140253.m6lpundvnvtfsloh@pengutronix.de>
 <ZXMzFVphyrcG8r9H@orome.fritz.box>
 <20231208181503.cjlajo3y5xc3vlqv@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2cUMxV1+XFQk3N64"
Content-Disposition: inline
In-Reply-To: <20231208181503.cjlajo3y5xc3vlqv@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--2cUMxV1+XFQk3N64
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 07:15:03PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, Dec 08, 2023 at 04:15:33PM +0100, Thierry Reding wrote:
> > On Fri, Dec 08, 2023 at 03:02:53PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > [...]
> > >=20
> > > Please pull this as a fix for the next -rc release.
> >=20
> > I don't know why you didn't let me know about your plans to send this
> > out. We should've at least discussed this.
>=20
> I tried to discuss that but didn't get any response. I pointed out in
> two mails[1] that I think this should go in before 6.7 and I announced
> this PR last week[2]. Also you usually ignore me on irc.

I'm no longer able to keep up with IRC, sorry. Email is the most
reliable way for me to communicate, although obviously that also doesn't
work all the time since I missed that last email from you where you
"announced" that you were going to send a PR.

> So I don't think "you didn't let me know" is a fair suggestion and I
> honestly don't know what I should do better next time.
>=20
> Given your reply might confuse Linus about what to do with my PR: Do you
> agree this bcm2835-pwm fix should go in before 6.7?

Of course it should go into 6.7 and it would've gone in. I usually pick
patches up into linux-next first because that's what most people will
end up running and where they will first notice when it's been taken
care of. Then I will typically try to batch things up and will usually
wait until around -rc6 before sending this type of trivial fix to avoid
sending multiple PRs for simple one-line fixes like this.

Linus has already pulled this and that's fine. But we now also see this
patch duplicated in linux-next and it's all leading to extra work where
people need to report this and I have to rebase my tree just because we
didn't communicate properly.

Thierry

--2cUMxV1+XFQk3N64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmV25jwACgkQ3SOs138+
s6F16w/8CXt0w4Gyc+eNoIhELo+kzQeUzp+8DvSs4yoYH8N9+jHxfQNqeL+91brp
ibkX5z5YiTSMrhdX8SIvNX0ufmPT3t/Uyk7MQDxM3u+V2L57pRg4lVdMNLFD+4ZH
snCNoi24TK7EpiIX2i3eIvkjjAvinQhU2uCpLEO+Kj89i2NEnAOM5ZahJyOgG40g
kUbymYinxhajo0ZqlVm/3hehEgQSDHi4DXMrrSQbTJYElk14WdMmI3l1IJ6dUrzA
d00+5GfKDarpZAJl8vrgGDaM1HOpYn5XqItFcM7+5Md12gBu/vjJIDjHvsdQAuty
cG42F5nfDYts+WBm+Rcebx4eNZhMELkKEPqZ7W0HMEj05qKFMDlE4lGunfi5LqOz
iHDTWlhKp6/kCII6d48YyxIOznuBmhbyQfmW+JIRklSmVv78h4hIknA72r5CPtaP
gnVTkQS1mnOvzbrAn95hH+P/94rQtOHvuSSZeMC+ENGwNNutj4sON+eQYnoo88nE
lKpTx0D2FNSa25zL+Hj7WK9aw4RginmqbO/0vNQosWwv1M+pHyF1jkhqM3PGd6mU
5oE9CW0EqOIvZkhrn573rtdfKXKrSuDtF76d4heJYS9jqcCDvhDLK3N7BQ9Eao9U
kXAD0BSz4VR6r/M/HnAIVWr3Zm1CKd2Fgg41INIDir+xzEYDdhI=
=WQ/e
-----END PGP SIGNATURE-----

--2cUMxV1+XFQk3N64--

