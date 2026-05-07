Return-Path: <linux-pwm+bounces-8841-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOguJF+s/GkNSgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8841-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 17:14:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E27544EADAC
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 17:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1ED2302ED60
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FD13FD124;
	Thu,  7 May 2026 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjTO0g55"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021C037475D;
	Thu,  7 May 2026 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166686; cv=none; b=MRt1gD/nRTbF7Lgj+Ws8eW0thW/LT0fT21s9+4tMECccOy241S7gvEbPANmyDI3L/WuYF39jgJ18PmY38N6hrYam7r5QG5dhiW7qvZ3BvUpX8ukTR4TLiiUJTfVrsLWjjC1ulETyPjTIuHDpXJn7vKsX7hwIGtbty4o0boexAEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166686; c=relaxed/simple;
	bh=hw6BsxqfUNxcdCQgU/QqcINBhjEnfbEwWEzmUoVMRII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8tITryaKd9ayz52G2078ILoiu3Cundl+YTb4lUS6NM5X/zBZe5MuxQ86jGm1RLZSlPXQ8qJak78FTp9WCS1nQQkXLb6+u79MK0N3ZQZKlru4iadFnHfc45h0hBRYvhI0EmTEhO2O6K37DE17a1SBACDu3miuW+Jfk1kdRuKY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjTO0g55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A931C2BCB2;
	Thu,  7 May 2026 15:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778166685;
	bh=hw6BsxqfUNxcdCQgU/QqcINBhjEnfbEwWEzmUoVMRII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cjTO0g55IsmvmDjMosOULgZ/KnM/MQ07Q+g5SxBVj7ilISoI0+PNZGxE3o5qVbp7N
	 2lJs/Ny6J9uH7O594yn+e4mb2+8W0RsFkXfC8FVuae3cL0D/YREZms7hMMD4KIlLzZ
	 m7n4tefDiQvxkrUILSO5nSkC4UxRgqlGjzl82eg7rolRiGp7WoB6TcvNpuO3TPVlxU
	 2eCl/6eBXo5z63kdnipuDKS8lxi1ZBfwaQ/eJBtmlSkbY1pnMa8e+oG55FXs0Cc+AT
	 axsfKKB/vDqTlG0Lz5hEfoZDUIR8TkYcjdg9hnY9zcWDbKw51ecuUF8bRrewvpsqa+
	 gOJ0njzUuT/aQ==
Date: Thu, 7 May 2026 16:11:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 4/6] iio: adc: ad4691: add SPI offload support
Message-ID: <20260507161111.555bba75@jic23-huawei>
In-Reply-To: <LV9PR03MB8414E7E034F79900A6595750F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-4-33e439e4fb87@analog.com>
	<LV9PR03MB8414E7E034F79900A6595750F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E27544EADAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8841-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


> > +		/* TX: address phase, CS stays asserted into data phase */
> > +		st->scan_xfers[2 * k].tx_buf =3D offload->tx_cmd[k];
> > +		st->scan_xfers[2 * k].len =3D sizeof(offload->tx_cmd[k]);
> > +		st->scan_xfers[2 * k].bits_per_word =3D bpw; =20
>=20
> "When bits_per_word is greater than 8 (like bpw =3D 16 here), the SPI fra=
mework
> treats tx_buf as an array of native 16-bit words.
> On little-endian architectures, the controller will byte-swap the data be=
fore
> transmitting it. Will using a u8 array and put_unaligned_be16() result in=
 the
> command bytes being reversed on the wire?"
>=20
> Switched to cpu_to_be16() assigned directly into __be16 scan_tx[],
> matching the non-offload path. This makes the intended wire format
> self-evident and sidesteps the byte-ordering question entirely.

This confuses me a bit because the SPI controller should work with
native endian and from that generate the expected big endian on the wire.

So on a little endian host byte order in address space is LH but it will
write top bit of H first thus the ADC channel address needs to be in the
second byte.
On a big endian host despite the ordering in memory being HL, the top
bit of H is still written first thus in needs to be in the first byte.


If you using cpu_to_be16() to assign a 16 bit value swapping only on little=
 endian
and start with the cmd in L on little endian you'll end up with LH swapped =
to
HL and on big endian HL but the little endian SPI controller should then sw=
ap
it again sending what it thinks is the high byte first (L) whereas the big =
endian
system will send H.

Upshot. I think the field should be native endian. If a byte swap is needed
it should be unconditional and not rely on endianness of the host.

>=20
> > +
> > +		/* RX: data phase, CS toggles after to delimit the next register
> > op */
> > +		st->scan_xfers[2 * k + 1].len =3D sizeof(offload->tx_cmd[k]);
> > +		st->scan_xfers[2 * k + 1].bits_per_word =3D bpw;
> > +		st->scan_xfers[2 * k + 1].offload_flags =3D
> > SPI_OFFLOAD_XFER_RX_STREAM;
> > +		st->scan_xfers[2 * k + 1].cs_change =3D 1;
> > +		k++;
> > +	}
> > +
> > +	/* State reset to re-arm DATA_READY for the next scan. */
> > +	put_unaligned_be16(AD4691_STATE_RESET_REG, offload->tx_reset);
> > +	offload->tx_reset[2] =3D AD4691_STATE_RESET_ALL;
> > +
> > +	st->scan_xfers[2 * k].tx_buf =3D offload->tx_reset;
> > +	st->scan_xfers[2 * k].len =3D sizeof(offload->tx_cmd[k]);
> > +	st->scan_xfers[2 * k].bits_per_word =3D bpw;
> > +
> > +	st->scan_xfers[2 * k + 1].tx_buf =3D &offload->tx_reset[2];
> > +	st->scan_xfers[2 * k + 1].len =3D sizeof(offload->tx_cmd[k]); =20
>=20
> "Will passing &offload->tx_reset[2] directly as tx_buf cause DMA mapping
> issues, since it is only 2-byte aligned?"
>=20
> Addressed by the second concern's fix: no sub-aligned pointer into the mi=
ddle
> of a DMA buffer =E2=80=94 the full 4-byte scan_tx_reset[] is passed as tx=
_buf
> from its own cache-line-aligned start address.
>=20

