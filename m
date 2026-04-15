Return-Path: <linux-pwm+bounces-8593-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CkfEQys32mOXgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8593-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 17:17:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78674405C92
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA55130DEE2B
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 15:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE653D890F;
	Wed, 15 Apr 2026 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="We3/qUEx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B04A3D88E9;
	Wed, 15 Apr 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265960; cv=none; b=AGqPRwgYTnyQpk7Kz4nCgp/s8ICKtT8Wy+Ac+p4tZGRkk5U8h3ZcesMhSSC0ndFLb/l55MNCwgZFzJiUz14aIRMj1uEas2+DnUWrtHEDzemNVHH4mrcIDSmsdZ9QKe6C2OBzxcArS/PnP71475RxnPB7G9Q/wsREkvBFazLHvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265960; c=relaxed/simple;
	bh=YUJjqqhI9gnFtU556Ey/dqmGHfXQ9/59t0+1jgwdbIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoWiEdkkNTESo+kVRKEFlBTai7lWqsR6m8J1uhbaFwmFc6Df4G6ZNODlXIUWCOWZOGRKVgthnF75HFC8fdgn66rHb5MMjW1UhuX5RqjCmB8uYnRnIH48ljGkjlL6SGI4eaCBGKSrCCcYyn/0R40gnvOq+5L910N1k4lsrE0GSD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=We3/qUEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C8BC19424;
	Wed, 15 Apr 2026 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776265959;
	bh=YUJjqqhI9gnFtU556Ey/dqmGHfXQ9/59t0+1jgwdbIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=We3/qUExm3NpUuEfh+Nhj5vfjEkZVXtEmFHLQMxarih9Vs8InW4IRliQcLEOcOFyA
	 q9ee479sSUDglZ0g/gHnfTVfMyf1d7XaRingMYQrql8Ib3cg1ogN4bmH1cssTbStuq
	 6sjwatgxMEmdyEfkT1FedUiekoNhAOGd2FOMosvmw30nkw2DBoIdjDzMqkZCStPbkY
	 v3wYDC4KL+DJjwsByqKnjVBWFMfaAMqE8NT/PUjsbmwM+mkcaxrqLCRJJTwX9y6xYb
	 UP6H1XrO4Gao346aaHQeNVXboGUjer7IXZSGE7guY2SLXGeQFepnX/ub6+NeAPmH6+
	 ZZLPF2E+p2gfA==
Date: Wed, 15 Apr 2026 17:12:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Sangyun Kim <sangyun.kim@snu.ac.kr>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel-tcb: Fix sleeping function called from
 invalid context
Message-ID: <ad-nOb2Tj9PombuN@monoceros>
References: <20260415093433.2359955-1-sangyun.kim@snu.ac.kr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hke3yhwg6rcplifn"
Content-Disposition: inline
In-Reply-To: <20260415093433.2359955-1-sangyun.kim@snu.ac.kr>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8593-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,snu.ac.kr:email]
X-Rspamd-Queue-Id: 78674405C92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--hke3yhwg6rcplifn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: atmel-tcb: Fix sleeping function called from
 invalid context
MIME-Version: 1.0

Hello Sangyun (I hope this is the right part of your name to address
you, feel free to tell me, when I'm wrong),

On Wed, Apr 15, 2026 at 06:34:33PM +0900, Sangyun Kim wrote:
> atmel_tcb_pwm_apply() holds tcbpwmc->lock as a spinlock via
> guard(spinlock)() and then calls atmel_tcb_pwm_config(), which calls
> clk_get_rate() twice. clk_get_rate() acquires clk_prepare_lock (a
> mutex), so this is a sleep-in-atomic-context violation.
>=20
> On CONFIG_DEBUG_ATOMIC_SLEEP kernels every pwm_apply_state() that
> enables or reconfigures the PWM triggers a "BUG: sleeping function
> called from invalid context" warning.
>=20
> All callers of tcbpwmc->lock (the .request and .apply callbacks) run in
> process context and only need mutual exclusion against each other, so
> use a mutex instead of a spinlock and allow the sleeping calls inside
> atmel_tcb_pwm_config().
>=20
> Fixes: 37f7707077f5 ("pwm: atmel-tcb: Fix race condition and convert to g=
uards")
> Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>

The issue is real. I first thought the lock isn't needed at all and can
better be dropped, but the chip lock doesn't cover .request().

It would be great if you could rework the patch to keep the spinlock and
instead make use of clk_rate_exclusive_get() at probe time and then
store the rate in struct atmel_tcb_pwm_chip.

Or alternatively drop the lock and call guard(pwmchip)(chip) in
=2Erequest(). (This however would require to move the GUARD definition to
a header.)

Without the mutex we could then do:

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index f9ff78ba122d..70856be12517 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -431,6 +431,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *=
pdev)
 	}
=20
 	chip->ops =3D &atmel_tcb_pwm_ops;
+	chip->atomic =3D true;
 	tcbpwmc->channel =3D channel;
 	tcbpwmc->width =3D config->counter_width;
=20
which is nice for some usages.

Best regards
Uwe

--hke3yhwg6rcplifn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnfquIACgkQj4D7WH0S
/k5QGgf6Aix/HhyOFhirW2v/a+a0tm/TCx7DqpvHmb1q0YHSZSdtt7HvjJ37NgYQ
kezD4YvZad2gWuxD3NoHSxFpX8UYQxMmmbCrEVu/WChDCal7YjulEgE9CYWT+xpl
dRUaJjHJc58fH7TpxFk6iiaM8AGJSABE9AVxihKaWXap/ISTkSfw0JKGhKhiuHJU
XBJZpTGoe2s7FcnlEkIPB7PBcMrjwTuK0B7Q9BtqC2WX4mP80qVBnLCKNYg05AS/
vmJzkfrDKn4Ph99Aljg8Fx1HIyCBkLvlomCvbJcpFd4+/5AjAxtYRsfNy+ZqyrHa
Sat6wL0g7ayLDFmwh1aVTGW21o6Sew==
=CSDc
-----END PGP SIGNATURE-----

--hke3yhwg6rcplifn--

