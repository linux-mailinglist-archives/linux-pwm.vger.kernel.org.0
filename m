Return-Path: <linux-pwm+bounces-9437-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2zQoCQsYQGrqbgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9437-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 20:35:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EB06D27D5
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 20:35:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=D3xD7o19;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9437-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9437-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DA213021E8D
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBA334575A;
	Sat, 27 Jun 2026 18:35:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC13305057
	for <linux-pwm@vger.kernel.org>; Sat, 27 Jun 2026 18:35:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782585342; cv=none; b=pp3DDyb5YBkjkM9sEqwoLL56yF19gVhmr9aO2TRon3fvBckTEspFgQYMEEUCNkpn/v1UzkG4iVii+n2glXk/GrvcY7if0poySP90GfHUKA20ViNf1Gn+4DvZIqQYgLwQTOLa1ehLe7Dum3/l59XVb30zgZsMfnaRoc8/BCNWqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782585342; c=relaxed/simple;
	bh=9Nhe9imUud5kgN2G32wHuYHPMd6GWFIZ/EFFv8zoO8E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QqCVpTB+3EAxsgZ66J9cFA3DWlWQpyhns/sEsWhe0FkKNyemeUzh+1olFNBjOHX6/2+YTjSkNmrpzG41uiBvzEXbqrTQbpISZXQVNdM5crV2YfgtSnaW/HsXN3DkHA9ObiBjUsV/kGChRcjt/bKPQAlO33JlHhr5e3E/qMF4TYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=D3xD7o19; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-472a14c9965so36683f8f.1
        for <linux-pwm@vger.kernel.org>; Sat, 27 Jun 2026 11:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782585338; x=1783190138; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSLzBuJEfRgApGDysq2dG5c3BDzqgvSAHh5tg4hundI=;
        b=D3xD7o19EkSxWq9GG66dp7x2O0jSou4dxwiMvXmzOPj6RiznvZ1YaXdcVu7QB+FpyF
         ghj6AVg7wWH0iJ1qYZ2ctP3NHrQfFFj3SxCsdmiBMpT8JBQLKa2DZ62wUDvzc4CQXNl6
         Kjvsd2L9PDnBsM0gFSElbsOwiG6OxMGEqTeR3apbVxoVABRktgLGhv3o9iyMJoRtdWaI
         HMpGg1eMH95jJffIVQ9pO01RDKH9NzWRd7f8xvflC2EUdTiZIGNucAWVjSbUtrbKhqwJ
         N6NllcVB1OlD8rQhPEVih7N3Hyp6PjNL3tKJBFlKZoyQToHAnEruxbEucbdUj/qfGDpD
         /GVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782585338; x=1783190138;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSLzBuJEfRgApGDysq2dG5c3BDzqgvSAHh5tg4hundI=;
        b=enaBxfyVH6JnCsQ5fbbeozvIQ2YbgksYgIvUZOhWIkTVxqPXsZMg8ffJcKj0BaXxzl
         2CcXb/wVZw4Nu3cMyxA/34cmWc0m9vIuNcdQ+fx9IXD6RcNDZFJNylmPtGkV/jVqJdmD
         wTjVbIlWvyEqQ3WQKHyvkTLyTkVYu/AUieYEYT0nud1fxwIDIDnqNJwfpds1aTyPJJdH
         /Fvx3PPSfXFcz4P5qqir8ZSLsElVlzH1AFk6NZAou38AZ0qg70OU+dI8kSy1zyFezCLU
         chjx2+6kyTz2zdVEpGRL9RKD+cdC4oXTADXmtioBT1skg4euu4OrMu6aKdfVUqPfN4Qz
         YBtg==
X-Gm-Message-State: AOJu0YxZKXOMoa61aFa29ZrOlEfIiZmONkzeS0RnToAJYyxCFIMdZMJp
	P7VrcuZVpWvwR9+ZRCFOAs7EtdiqMGGolIacvUDznFVIB1q5A1safJlpRWLgbb+a498=
X-Gm-Gg: AfdE7ck2sDP1rENueXiP4A8hwPUP8pbbU88GIAdx2P6zTq/gS4MtjiM/nOuVcFmmdYO
	NTyXZMaj8e4baZkyPpB595MeodALOaw3/iqa5NM1io/uw1WsC2ZrJLpszgHJpM5c1JiBI793X8K
	etsQFNSK7nz3eKJY41sB0Js/ZJ+WfkBg0sTea+pjqheCA2EcYymwJg5NSbM7OO08ogPvu/eZKbY
	N2JSBV+dIHhTzRoSa6908NOQZFLT9r6OgdiGE7L/vKiP8pxH9PZoJcE24X87kz+uleGiPwVmJVg
	5DK4UcXXA7FX3IHrgd4WUq2gIJv/fPstoPXvO/ohasiBAhy/9OVm09E2UVVgHDBL/zQIQ8EcjtY
	VdX+x8SqmgCUzafkLPfGYK2H9ZTUNRSoDsVD6Z10IM9Wts6FVBavE3IkA34D+PLIR2lUBDlldSZ
	qpy24e5idqVZEqPxTpOw==
X-Received: by 2002:a05:6000:1867:b0:46d:8695:f49d with SMTP id ffacd0b85a97d-46dc2a1614cmr19081759f8f.34.1782585337510;
        Sat, 27 Jun 2026 11:35:37 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c2279bc77sm33171172f8f.32.2026.06.27.11.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 11:35:35 -0700 (PDT)
Date: Sat, 27 Jun 2026 20:35:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [GIT PULL] pwm: Changes for 7.2-rc1 (batch 2)
Message-ID: <akAWnuys9snFTiB_@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7korg276coc3xsgt"
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:biju.das.jz@bp.renesas.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-9437-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,monoceros:mid,baylibre.com:dkim,baylibre.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0EB06D27D5


--7korg276coc3xsgt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] pwm: Changes for 7.2-rc1 (batch 2)
MIME-Version: 1.0

Hello Linus,

the following changes since commit 6f9b73071c15001530e6697491b6db1bf639f4c7:

  pwm: th1520: Remove requirement for mul_u64_u64_div_u64_roundup (2026-06-05 14:03:00 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.2-rc1-2

for you to fetch changes up to 898ab0f30e008e411ce93ddf81c4099abd9d4e46:

  pwm: rzg2l-gpt: Add missing newlines to dev_err_probe() messages (2026-06-09 15:46:00 +0200)

These two changes were in my public for-next branch but for reasons I
fail to understand not in my local branch that I used to create the tag
for my first PR to 7.2-rc1.

Given they are fixes and in next since 2026-06-09 I consider it save to
pull them into your tree for the next release.

Thanks
Uwe

----------------------------------------------------------------
pwm: Changes for v7.2-rc1 (2nd batch)

Two more fixes that I managed to put into the public branch merged into
next before my first PR but missed to include them in it. The first
change is a relevant change that fixes misconfigurations due to a
variable overflow. The 2nd is only cosmetic but very obviously an
improvement.

----------------------------------------------------------------
Biju Das (2):
      pwm: rzg2l-gpt: Fix period_ticks type from u32 to u64
      pwm: rzg2l-gpt: Add missing newlines to dev_err_probe() messages

 drivers/pwm/pwm-rzg2l-gpt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--7korg276coc3xsgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpAF/IACgkQj4D7WH0S
/k6M1Qf+PHp0u8oed942MUVA3LX/KzZqtgCkENIs3GLZB3dbcs9Evd5CqRm2b3bi
d2zDnzNUnB5ERY8/eozrh+f4GBYIx+5b9H99gjonCWDu+bFxa6J4JFeuPTQw40A2
S21ODqBOT9DRE0ZE6y6zJ5vvN5rs0usfQqxnAibd+YYExXPcByQWnTak142GNUay
GgvFfS8iITgAe+gHNLP/Ig82RMz+4PKWrwmg56/TLMSJncyggZhRLflJlXEeNspb
Ux33Uh+WeeskxghTtuEkucjq0s3+Pc0KDzCzcJT70ZfYiIyY9UPOI79If894Vcgw
/Ul3qWmMmXli0RVUd/tX/gS8OQDDJg==
=ikya
-----END PGP SIGNATURE-----

--7korg276coc3xsgt--

