Return-Path: <linux-pwm+bounces-3875-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD6E9AFFB5
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 12:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4877E1C230F2
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74CE205121;
	Fri, 25 Oct 2024 10:08:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31DF20409E
	for <linux-pwm@vger.kernel.org>; Fri, 25 Oct 2024 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850936; cv=none; b=qUoi3AEha2ijCUAvOH0HQ46f1ENp3fr2ZjHpI6P3PjZSA6dAqU8tbsnBFZgSylYVvbz7vIH+CfStxygVjoVafEiSuvgasWAEMVN8AhzfBKaouxuQTlQZqFm7I/Lnr2sy5iJdLjD8ADsgZKhC89ug1pV2S89anvKc92DgDmOnqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850936; c=relaxed/simple;
	bh=Id4jYVicQwF482cby8uyMk+tHNJ5kEp195Hkx8X8c+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Idq4E+sqk5EZlDBjMHDgYYMi5vu3ao8oKmhiERSgBs5hptBufjZsVmxyY6CeZLm17DAJ6TxYZjve3uCfp2oyjX3cdGfajMByv653+Q0temoi3vC6wOkrfn8PtTwXcSmv4uUTUgU+ot6q2div7iPqzWKDB6XquUl3YtUvT8VbRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t4HEv-0001dh-7U; Fri, 25 Oct 2024 12:08:17 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t4HEs-000LQz-1i;
	Fri, 25 Oct 2024 12:08:14 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0F74735E930;
	Fri, 25 Oct 2024 10:08:13 +0000 (UTC)
Date: Fri, 25 Oct 2024 12:08:13 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lee@kernel.org, linus.walleij@linaro.org, 
	brgl@bgdev.pl, andi.shyti@kernel.org, mailhol.vincent@wanadoo.fr, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, wim@linux-watchdog.org, linux@roeck-us.net, jdelvare@suse.com, 
	jic23@kernel.org, lars@metafoo.de, ukleinek@kernel.org, 
	alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1 1/9] mfd: Add core driver for Nuvoton NCT6694
Message-ID: <20241025-truthful-honest-newt-c371c8-mkl@pengutronix.de>
References: <20241024085922.133071-1-tmyu0@nuvoton.com>
 <20241024085922.133071-2-tmyu0@nuvoton.com>
 <20241024-adventurous-imaginary-hornet-4d5c46-mkl@pengutronix.de>
 <CAOoeyxUhnyYG3p+DQJG-tvU5vc5WYQZLLqCXW=uPcXTjq2gVfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4f2xpxewuk3idolr"
Content-Disposition: inline
In-Reply-To: <CAOoeyxUhnyYG3p+DQJG-tvU5vc5WYQZLLqCXW=uPcXTjq2gVfw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--4f2xpxewuk3idolr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/9] mfd: Add core driver for Nuvoton NCT6694
MIME-Version: 1.0

On 25.10.2024 16:08:10, Ming Yu wrote:
> > > +int nct6694_read_msg(struct nct6694 *nct6694, u8 mod, u16 offset, u1=
6 length,
> > > +                  u8 rd_idx, u8 rd_len, unsigned char *buf)
> >
> > why not make buf a void *?
>=20
> [Ming] I'll change the type in the next patch.
>=20
> >
> > > +{
> > > +     struct usb_device *udev =3D nct6694->udev;
> > > +     unsigned char err_status;
> > > +     int len, packet_len, tx_len, rx_len;
> > > +     int i, ret;
> > > +
> > > +     mutex_lock(&nct6694->access_lock);
> > > +
> > > +     /* Send command packet to USB device */
> > > +     nct6694->cmd_buffer[REQUEST_MOD_IDX] =3D mod;
> > > +     nct6694->cmd_buffer[REQUEST_CMD_IDX] =3D offset & 0xFF;
> > > +     nct6694->cmd_buffer[REQUEST_SEL_IDX] =3D (offset >> 8) & 0xFF;
> > > +     nct6694->cmd_buffer[REQUEST_HCTRL_IDX] =3D HCTRL_GET;
> > > +     nct6694->cmd_buffer[REQUEST_LEN_L_IDX] =3D length & 0xFF;
> > > +     nct6694->cmd_buffer[REQUEST_LEN_H_IDX] =3D (length >> 8) & 0xFF;
> > > +
> > > +     ret =3D usb_bulk_msg(udev, usb_sndbulkpipe(udev, BULK_OUT_ENDPO=
INT),
> > > +                        nct6694->cmd_buffer, CMD_PACKET_SZ, &tx_len,
> > > +                        nct6694->timeout);
> > > +     if (ret)
> > > +             goto err;
> > > +
> > > +     /* Receive response packet from USB device */
> > > +     ret =3D usb_bulk_msg(udev, usb_rcvbulkpipe(udev, BULK_IN_ENDPOI=
NT),
> > > +                        nct6694->rx_buffer, CMD_PACKET_SZ, &rx_len,
> > > +                        nct6694->timeout);
> > > +     if (ret)
> > > +             goto err;
> > > +
> > > +     err_status =3D nct6694->rx_buffer[RESPONSE_STS_IDX];
> > > +
> > > +     /*
> > > +      * Segmented reception of messages that exceed the size of USB =
bulk
> > > +      * pipe packets.
> > > +      */
> >
> > The Linux USB stack can receive bulk messages longer than the max packe=
t size.
>=20
> [Ming] Since NCT6694's bulk pipe endpoint size is 128 bytes for this MFD =
device.
> The core will divide packet 256 bytes for high speed USB device, but
> it is exceeds
> the hardware limitation, so I am dividing it manually.

You say the endpoint descriptor is correctly reporting it's max packet
size of 128, but the Linux USB will send packets of 256 bytes?

>=20
> >
> > > +     for (i =3D 0, len =3D length; len > 0; i++, len -=3D packet_len=
) {
> > > +             if (len > nct6694->maxp)
> > > +                     packet_len =3D nct6694->maxp;
> > > +             else
> > > +                     packet_len =3D len;
> > > +
> > > +             ret =3D usb_bulk_msg(udev, usb_rcvbulkpipe(udev, BULK_I=
N_ENDPOINT),
> > > +                                nct6694->rx_buffer + nct6694->maxp *=
 i,
> > > +                                packet_len, &rx_len, nct6694->timeou=
t);
> > > +             if (ret)
> > > +                     goto err;
> > > +     }
> > > +
> > > +     for (i =3D 0; i < rd_len; i++)
> > > +             buf[i] =3D nct6694->rx_buffer[i + rd_idx];
> >
> > memcpy()?
> >
> > Or why don't you directly receive data into the provided buffer? Copying
> > of the data doesn't make it faster.
> >
> > On the other hand, receiving directly into the target buffer means the
> > target buffer must not live on the stack.
>=20
> [Ming] Okay! I'll change it to memcpy().

fine!

> This is my perspective: the data is uniformly received by the rx_bffer he=
ld
> by the MFD device. does it need to be changed?

My question is: Why do you first receive into the nct6694->rx_buffer and
then memcpy() to the buffer provided by the caller, why don't you
directly receive into the memory provided by the caller?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4f2xpxewuk3idolr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcbbgoACgkQKDiiPnot
vG/Pugf+ObTDE98nVEGp4EcyqhJyQBDA7uMVUaRKfRJjRU3lME9NUAKlI+hFGnJD
mTOltVrzgv6BxOzCoXZbJyD3STCRKGW6BX3ZGrdHIWQE35gPkjCBOxLjFX43Au+F
ETIi+NIRxYShZK+4zefxtrHZRzbs8jD2qNzWLunIZiPTNKQQHIFFEcbZBTIDMBNL
3Vnnp8PYRUAidFfE6TbOst7NN8pO+a0f3sSBWMUxCMkAuPdLw2n/vIDc4IRXFF6A
aMorZ2+E0L3J9XP4gTpGzT4/qddFfKghSfustNU+x51YHxzYaT76TSF5nnnol5UY
mwp/qtRNUwo6A7boZWYDPeVhxEtrYA==
=RKzJ
-----END PGP SIGNATURE-----

--4f2xpxewuk3idolr--

