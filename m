Return-Path: <linux-pwm+bounces-8104-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P1nMlWiiWlU/wQAu9opvQ
	(envelope-from <linux-pwm+bounces-8104-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Feb 2026 10:01:09 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E9410D4D1
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Feb 2026 10:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3480830541F8
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Feb 2026 08:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB32332572C;
	Mon,  9 Feb 2026 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Hm28XDGZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A44E325726
	for <linux-pwm@vger.kernel.org>; Mon,  9 Feb 2026 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627385; cv=none; b=XwWeK8v0/fKLJ2ikCWhhkeStiKGiF1z7SWfyqoGhTNQv1aZOleRroEFWsAJrrQ/YaFPmjCkF+Tkmi9v8YBw+4UZF+7KxQx96MpjJmaiL9WDiYcft9tcCaj8z0JGgeNuZFrfaTON9Wgej+9rqApbXEP+YYnlvc9aqwhuEk7M3zqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627385; c=relaxed/simple;
	bh=345KCBHXVz0ZEx4i499l02tPXQld7swNF78syM+F1Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKZ/4Gz+YO3HSyKe7lys+eElUzMsbi8IJgPK7Sj3vAarg2mKAJuyuWikaI0KXnfr2iUCBwmzcjwsBlHexZ6JzN/ks2jUma9//ctXFgPWGSCssY2ZpHrZxLph5D1qWLDo3aDl4Z0dLLggxDslXz6i4uqCrM5HT6FDU9HcesF9dio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Hm28XDGZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso9967205e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 09 Feb 2026 00:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770627384; x=1771232184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jU1e6cGfVovzfgBd9x95W/1mOj66I3de/7vGBXXyBSg=;
        b=Hm28XDGZmnpAayfYirrKHLg1QZBqBufymRvPBD1qjIFmhtZvmUnUQqAiSSB0n3rDgD
         QWG/OsM5hpxWUO3jeoBYDYECHznEyM3BCliangxoXtIXKCHokBNp3NXsqI86RLfJnxk8
         NCrXSwtR07nKoNIfW1V7Iq6KV7FJrMZK/cJT8IM11DvZtqeS1CFjgS3892EEx1ga0/l/
         m0O56SYcBjwDBr/0KoXFIxIvcpFPrW39aYBAWrCN4rvRhQHWifUTlsvsc6fQxG1U+2u8
         2qDbR1bU8q6GRSRSw6S9Ye8Fh2hgyFMDmxh8NLl2q6Jh9KOOxAzItiy0SevGxwIjdNQe
         dKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770627384; x=1771232184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jU1e6cGfVovzfgBd9x95W/1mOj66I3de/7vGBXXyBSg=;
        b=uMC19S2UcwwUDjj9J1qfAVa+kzYjNMjiTAwz82+uzSt7PLH/JsPMPbJMJRLMTxptYZ
         sLSQS09S3V0JUZuJNZopLEkVBw/kA6Ur6pubvxk0QxrbCYySe44jW5P7uQ2yB3AEDzam
         OFxKDoQfArilxxZw74O49O2olMXa4LtW2+gau2VLjkMskI7nnwV89sU3BOaZFjB88mTZ
         2/1pjgrdd7LucLHTTS++2JxX3y1397fLdA9o9YM/5DDcQJJ5WzSAKXKieDxZkAHmOFZm
         rog6HWsb/EKv6GjnJ4ZZ9Qtow6sU7cLv1nPSEqdPGKxAAkpEhzrJUliGz/3LVUFqDUZP
         NcDg==
X-Forwarded-Encrypted: i=1; AJvYcCUZtKnY6OQnImX3mOwN+9VvU4HfLHC4uyXhq0Mwrmxh+VyrsCxtrOABG6q+REXb6kkmsn/xxQiahGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGwzsbb3QsQjvSGBpLq8Zt+srR9EgwLjFqa9RWUm2XnCN0CmJD
	hdltus/OSngTdmipvFDLPwUTMIz06PUp0s8xKRRB0ussChJQHyNvubQj0MS//vUDhCI=
X-Gm-Gg: AZuq6aJoxDvSQHjdNiI1QVnHovmTdvcVeQUsab8W6fpzCK+lgB2CoJhpjZmXIv8SmJi
	2CJXAB04LXy/395BJCZIEv6DROMqt9Xv59GBh4S9OnkFVknroKVELfNlbRT3FXpnaEbACHjV2b/
	RzgzCbj7dmZBi4x6Kpd1bShp39yA4ucuTxtn7ss/ngJ4H11fG0qJL4+h44VXVk6WZvGaPXhVnox
	nLK6qgJmhhmnf/kK7HK1PMG5XCmA0FFvpdj9M2I7bu+KX10HpU4mNhXbMoafdiET4tvOuq6SO2A
	S4ikwRlPNYQrTfIMb4tZ+64e9a50+vv3iPr3HnbbqqzlwXfcX5g+Vvhde67P3D8gK25mABhSq6l
	uw7fN0d2w4fdLk1BTxmnqi5f9C66eM3PV1bIDUk0cuPGtg4dex/UAkkyvChnFaxO7+Z4+HixgJr
	u87nAHq0/PkiwmbMSzNveC4aOnmpOOxwSJ7Bzpwx4GrjWGN0ml59lmgqR6sg0EKBsD3Q6XeZoqU
	zI=
X-Received: by 2002:a05:600c:3b23:b0:47f:8c05:786b with SMTP id 5b1f17b1804b1-4832021eae9mr148505945e9.28.1770627383577;
        Mon, 09 Feb 2026 00:56:23 -0800 (PST)
Received: from localhost (p200300f65f20eb04869299441cec46c1.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:8692:9944:1cec:46c1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-436296bd1c9sm24833439f8f.15.2026.02.09.00.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 00:56:22 -0800 (PST)
Date: Mon, 9 Feb 2026 09:56:22 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, linux-riscv@lists.infradead.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	rust-for-linux@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: th1520: fix `CLIPPY=1` warning
Message-ID: <aYmgjEWaLrdsubKM@monoceros>
References: <20260121183719.71659-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ry77kcf6b3keyw4r"
Content-Disposition: inline
In-Reply-To: <20260121183719.71659-1-ojeda@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8104-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,lists.infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[ojeda.kernel.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_TWELVE(0.00)[17];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 78E9410D4D1
X-Rspamd-Action: no action


--ry77kcf6b3keyw4r
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: th1520: fix `CLIPPY=1` warning
MIME-Version: 1.0

Hello Miguel,

On Wed, Jan 21, 2026 at 07:37:19PM +0100, Miguel Ojeda wrote:
> The Rust kernel code should be kept `CLIPPY=3D1`-clean [1].
>=20
> Clippy reports:
>=20
>     error: this pattern reimplements `Option::unwrap_or`
>       --> drivers/pwm/pwm_th1520.rs:64:5
>        |
>     64 | /     (match ns.checked_mul(rate_hz) {
>     65 | |         Some(product) =3D> product,
>     66 | |         None =3D> u64::MAX,
>     67 | |     }) / NSEC_PER_SEC_U64
>        | |______^ help: replace with: `ns.checked_mul(rate_hz).unwrap_or(=
u64::MAX)`
>        |
>        =3D help: for further information visit https://rust-lang.github.i=
o/rust-clippy/rust-1.92.0/index.html#manual_unwrap_or
>        =3D note: `-D clippy::manual-unwrap-or` implied by `-D warnings`
>        =3D help: to override `-D warnings` add `#[allow(clippy::manual_un=
wrap_or)]`
>=20
> Applying the suggestion then triggers:
>=20
>     error: manual saturating arithmetic
>       --> drivers/pwm/pwm_th1520.rs:64:5
>        |
>     64 |     ns.checked_mul(rate_hz).unwrap_or(u64::MAX) / NSEC_PER_SEC_U=
64
>        |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: consider u=
sing `saturating_mul`: `ns.saturating_mul(rate_hz)`
>        |
>        =3D help: for further information visit https://rust-lang.github.i=
o/rust-clippy/rust-1.92.0/index.html#manual_saturating_arithmetic
>        =3D note: `-D clippy::manual-saturating-arithmetic` implied by `-D=
 warnings`
>        =3D help: to override `-D warnings` add `#[allow(clippy::manual_sa=
turating_arithmetic)]`
>=20
> Thus fix it by using saturating arithmatic, which simplifies the code
> as well.
>=20
> Link: https://rust-for-linux.com/contributing#submit-checklist-addendum [=
1]
> Fixes: e03724aac758 ("pwm: Add Rust driver for T-HEAD TH1520 SoC")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

Looks good to me. I'll wait for Michal to add his blessing and then when
picking it up tend to drop the Fixes line. Or do we also care about
CLIPPY-cleanness in stable?

Best regards
Uwe

--ry77kcf6b3keyw4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmJoTMACgkQj4D7WH0S
/k4zeAf/XYGAKk/eo6iDxvksTOmu3h5TkJUmEfcgxwPtvFEjikx0NKtlrbr5z5Pg
FPa/A+qSRAoxsR8Igwk8Y266YgdRS+4EwmmeKUupEY+SJFcfb+AVXx1q/Upy0B2E
jh5VCVD3VYDDM0gbaX7oEndU2edusd/Thag3PVdz8UoIpk1rEQPCV1Jz/NcCGoLU
uAw2lwAWG5YUSufm9QUCd1nu+4iH+rgGXr8844D3wK7B+6JJ91wJaFHWjFfXpNTA
wPJLf004PxvX3aVVGZVZk/jtMHKIVE+0rOKdnoPbUyu3flk4W+qJaXtV+jYZ32BT
xpbO4ij+bh7NNur4IAy8OSBPnEk+cQ==
=5cZO
-----END PGP SIGNATURE-----

--ry77kcf6b3keyw4r--

