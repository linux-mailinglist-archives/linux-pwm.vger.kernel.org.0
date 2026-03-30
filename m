Return-Path: <linux-pwm+bounces-8426-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK/8BZ3yymkkBQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8426-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 00:01:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 678EB361B45
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 00:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F5173031331
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 21:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6423A7595;
	Mon, 30 Mar 2026 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="G2QozNkI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841113A6EEA
	for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907700; cv=pass; b=Vx9amn3l7Qjbi9h+iofwJEGQtgoR/RVxjUB1lrzxHblk+VgPllKAqLxtjoOAxVhD9BQqXWro7E2ooqZkNtonTaM9lkzm3kDRBUtzJ/+Pz5lkbnIFfYUrhbwuH/H7XUdcZUxS4SnCAWrWXGWXUmzgwE3E9o/OKsciMYKohboE/Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907700; c=relaxed/simple;
	bh=xN/QkzMYPIlbhAvsrH44ktU+4AeFHj8GPyLj9MABI9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+6JTNMZqI9v1zfBVc2JlGuXoquzBOIvYydeLUnRjziI7lI1TpmfZ2bF5ScnGs/frHbW8my4aZ2nx4R+MbfivLtthEDU/fufFkz9urfab2U3UKvpy3g+ldMvLciSOFQNNsSHA203XYgjHBU096oz3aePtMGywua/oLG5wx74wog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=G2QozNkI; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so1294287a91.2
        for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 14:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774907699; cv=none;
        d=google.com; s=arc-20240605;
        b=g3YXAs+CHmcbR34tsDG+W609jnHjMEQAN+BetiPAK0DfwwPIUP0y4LLs64C89ww7b5
         5SH5PY2k9dllQteERsXh0Bh/7pLeRTT+JL73sK398p4XhLy7X4dvTZj49i/xqiTVwzX7
         PzmItTncBMC1rHQTEN9GSqX0zSHY0PaqyYgymjzngcRexVG83botIAhTpok05YpeTbfN
         eFFwFKdiaPAqp4up0mQ2GamV3CwvNULCrznpJx07YMRvjnlKBBkw07ajOAwoxoiwyTcc
         v3SMpJdG0s1Nb9LzWvcqmfhczh1X1+FmS6c0WasGweUxsjUAABIU5s8MmBuSv89weEsi
         b1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xN/QkzMYPIlbhAvsrH44ktU+4AeFHj8GPyLj9MABI9Q=;
        fh=POJ6okXbRgY9a7A7Xzzy0HjYgkS9g7a52HEj7cXGRhk=;
        b=jjKSvRJ7p6dcK5qdl3J80W7JGTwBOEtXDSBK6CIo/fJlvZba20Iw2GvMVuuAUMDUop
         w8AsZ3y9wbLdcWg+5hhmVb7LGDSlmaBicOrdn+NfXO9I/Hyyn2wSepyas+EgbgE5OK54
         HUZ7Anvu1YmYP+9+kbtBVukwSgy3EDAqZV+akk0Uv69+pnVPYHobPdtpq7zeC7A1aMHs
         a2OTG3hwFBdnH+iHKEECI3U9V9XDMQq7PGCYIb6mH+Yg1rhT0e01jVgdoxJtgCqpikSU
         u2T9j4ebcF1dBOjTQMLuGUQfskGTpd6FfjhW/0waEHXTGMHVsUZT4H4WvkQyVaVS9UD6
         XUCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1774907699; x=1775512499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xN/QkzMYPIlbhAvsrH44ktU+4AeFHj8GPyLj9MABI9Q=;
        b=G2QozNkIg4zrjrvYO2TT9ExjgSfTjtuK0Qa3IXbWjX3/e9CDFEMbYRSb8TAcLUlaNR
         qAfcSsA8JMl1DgRhJXVKG0ri5D7QTgOM+CA3OSxbWzHScT1ioDLdVxoO5SXuyvpC5ymX
         p8lt19k8rZdGzZEiUQLf2UO0qaKHN/+h9u6bPBUos/bP8Eyl1n0egE+LomzSb5Ls+Gct
         7PazMxxxArwfUdj9VAA7WihLdBZvGb7l9h16sqDeBRirT9EmTjxZH1q68l38mzZn5806
         yElO/ET8Vy8ojtQkyN0EaDxpTfjACoeYmZqzgWpMlAWTnTuady8PnJ5BFaPKJp5PqrOJ
         ZIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907699; x=1775512499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xN/QkzMYPIlbhAvsrH44ktU+4AeFHj8GPyLj9MABI9Q=;
        b=kqpI96m3imAV8ARnoQz8SvraEi0GM+6kUklyrtE+ZOGtRBUd/0rBaADEJLJQqmp9Vw
         urkBS5rZ/49NLDvvQn1Wh/xkd9Z60Lim1A34lsNv3j2I8Fpxt3rl96jcufXxBm3KNp6v
         MxjfmRLKDoqGIAsGxiwBt0xZ+P2ODBxcDeiblEmiiNUgnaMLsRRkn36Rb7Nrw47HRq4p
         aUTPbJ3B2zMyUi23ViF38hN8ssWe6c50CfyFyoi+1cC8KG1Ra9qi6eNgBQJK9fq5KRAV
         qcHZQNqqSMmrgTfu1t1XWehu6lk5VbkvuxFCFh64jGN67p5JTYvDCve8nGXeh3uviSRN
         5JaA==
X-Forwarded-Encrypted: i=1; AJvYcCUokPyZ2hXTO/kvMDtERD7zjJvgqt8RX0ICNcVGi+wataElKDRCvaNhzcKIy2AFtqne0kenPlbv0EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH78GDsJVAMD2j3eBSI7lWHHkAodWkApEO1RWdJDxQlJiDxiNt
	1bSsxXp0nYqKh1qlgjVAvD8e3Qsq3kpQ4dwauPLBqwuj8H9jWEWt4IrKjhWl0Coo3Jq/JtTAff7
	FGr3lgCp8mcHVLKUMwUqiOalsmcIQLnI=
X-Gm-Gg: ATEYQzzpuCucKjosl+PANsarPDiY/IXKzhe32fil2XrlRrJ8au41oU/xy0tlcnocsUs
	iqc8/7b+O+8QpaI1Rs3oZjheEXRkpCzjlo4GXSYegX082tve+9d4c3wiKKhvWvC+4+kIXqVOYzO
	MnWu1veox3L9Cq3Qv/F6pq0qL/SKI8eAx8jNutm68OKew2VfseJFPwpWMYI9cabk3pfKdvCdvmF
	oFdEelMRaGVX9/1JDWRVXEFRFBgq34l3w/rYP/gncCn4tHmGDMTq2J5x8mzy4esiuqTiCwxfpJw
	gXBQmK2Z5sxJb8GdBHTMGvpR3ecl65Q9+WrFQP1jCY+2FDLNOsA=
X-Received: by 2002:a17:903:98d:b0:2b0:60f1:de58 with SMTP id
 d9443c01a7336-2b0cdcfae43mr147607145ad.45.1774907698891; Mon, 30 Mar 2026
 14:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com>
In-Reply-To: <20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 30 Mar 2026 23:54:47 +0200
X-Gm-Features: AQROBzC2-9WP_iYu993gr4kZhNfXgWBsXWt6220pBOvgiFbgiwhI3kcyG0LtR-E
Message-ID: <CAFBinCD1GPP82MEBDHg3BwCJg6JY5k2HksEt+kCB=YjnYTO7Tw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add PWM support Amlogic S7 S7D S6
To: xianwei.zhao@amlogic.com
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	Junyi Zhao <junyi.zhao@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8426-lists,linux-pwm=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martinblumenstingl@gmail.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,vger.kernel.org,lists.infradead.org,amlogic.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 678EB361B45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xianwei Zhao,

thanks for your contribution!

On Thu, Mar 26, 2026 at 7:35=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> Add bindings and driver support Amlogic S7/S7D/S6 SoCs.
There is an old report that got lost, stating that the current
pwm-meson driver has an off-by-one error with the hi and lo fields:
[0]
Since you are working on bringing up a new platform: is this something
you can verify in your lab?
To be clear: I'm not expecting you to work on this ad-hoc or bring a
patch into this series. However, it would be great if you could verify
if the findings from [0] are correct and send an updated patch in
future.

Thank you and best regards
Martin


[0] https://lore.kernel.org/all/20241225105639.1787237-3-gnstark@salutedevi=
ces.com/

