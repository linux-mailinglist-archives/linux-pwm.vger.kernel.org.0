Return-Path: <linux-pwm+bounces-8177-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPiwIchDqWlV3gAAu9opvQ
	(envelope-from <linux-pwm+bounces-8177-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 09:50:16 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FEF20DBB6
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 09:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71D8E3034B05
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83379375F76;
	Thu,  5 Mar 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeBENYUV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F36C375F67;
	Thu,  5 Mar 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700560; cv=none; b=Bgg6igBuBhrsW1W0Xe/9jnWniSf3mzLvWo5WWHsb9O54etW5armGumTXQIZL1C9IDb41JGu7E/TrzKA2YHQZdUTF7Zc9oRjHS3tKOyD15Xe7+PB3GxEfkca9EHmKgCeCBvi+jLP+XtP/TD0L+YdIKe9zJSQOI4VJtlGHKvw/Hm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700560; c=relaxed/simple;
	bh=UEwttngTQsmLLtKJ8DFAkKkPp9TkJbnDTb161dzvgCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWpV8PjPttthJGo93kSW2JdcNnmiJxEjOLuf/KA5Wz+E8aUJelkqDlcybkOR9KKOYKptO7u0zI5cnVR2vXKtrjEIM720D8L4O0HovKt7BuQm3yfBhE6LRNQN/UM9xdIRKHVvcPvRgOYVjSj+guv6w+VSROMD7Tl4l6zqZ/HhigI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeBENYUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926E0C116C6;
	Thu,  5 Mar 2026 08:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772700560;
	bh=UEwttngTQsmLLtKJ8DFAkKkPp9TkJbnDTb161dzvgCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oeBENYUVSaUIgTeVFRD5YBJxrw75e0yO3ekO3RJ5WXmoWo3cZ8gL9GakH+D84ZtKS
	 qK6fR73ch5JgXbzyaZs303hpQGym5CQrHRjfKmXwKnza3IglQrzyfeuUAmoxewkYcr
	 JI/rq5Lvmrqcod1d2hi5HA6nKV518xfNYDs6S0WaYW10tZ01vqPhaTRDAbL+2yQNam
	 /xu1RdzmrY3gv8ZUm5EUmvtRQ57yR41xdtYAG1RXLNUkM1kioldrmuoZBMLN4bqhgM
	 gIWZQlTY33jhfLSudmIdi8e/jnpT4Rfbc+9lDyQuKNaDU7sDCoyFg+D9AKpGRqJgwh
	 TkFg/lCX+vQhQ==
Date: Thu, 5 Mar 2026 09:49:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	William Breathitt Gray <wbg@kernel.org>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/5] Renesas MTU3 PWM / counter fixes
Message-ID: <aak9_ran81EPmjpm@monoceros>
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="73k3u4jandqqyizn"
Content-Disposition: inline
In-Reply-To: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Rspamd-Queue-Id: 87FEF20DBB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-8177-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


--73k3u4jandqqyizn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/5] Renesas MTU3 PWM / counter fixes
MIME-Version: 1.0

On Fri, Jan 30, 2026 at 02:23:48PM +0200, Cosmin Tanislav wrote:
> The Renesas MTU3 PWM and counter drivers have some issues which have
> been observed while adding support for the Renesas RZ/T2H and RZ/N2H
> SoCs.
>=20
> This series fixes the most important issues which prevent normal
> functioning of the driver, while other less important issues will be
> handled in a future series.
>=20
> Questions for the PWM maintainer:
>=20
> 1)
>=20
> The handling introduced in patches 1 and 2 is similar to the approach
> taken in commits [1] and [2].
>=20
> Is this the right approach?
>=20
> This code snippet below extracted from drivers/pwm/pwm-rzg2l-gpt.c
> entirely prevents the period ticks from changing at all when two PWM
> channels backed by the same HW channel are in use.

Yes, this is a known issue. But there is no sane alternative I'm aware
of as one consumer must not change the settings affecting a different
consumer.

> if (rzg2l_gpt->channel_request_count[ch] > 1) {
>   u8 sibling_ch =3D rzg2l_gpt_sibling(pwm->hwpwm);
>=20
>   if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
>     if (period_ticks < rzg2l_gpt->period_ticks[ch])
>       return -EBUSY;
>=20
>     period_ticks =3D rzg2l_gpt->period_ticks[ch];
>   }
> }
>=20
> Same logic has been imposed in patches 1 and 2 as the HW limitation is
> similar.
>=20
> Based on the logic here, a second channel can be enabled as long as its
> period is larger than the period of the first enabled channel, and the
> period and duty cycle will be adjusted to be <=3D to the period of the
> first enabled channel.
>=20
> But once the second channel is enabled, there's no way to adjust the
> period of either channels anymore.
>=20
> Wouldn't a better solution be that the smallest period between the two
> channels is used, so that adjustment is still possible dynamically?
>=20
> Here is an example.
>=20
> echo 0 > /sys/class/pwm/pwmchip0/export
> echo 1 > /sys/class/pwm/pwmchip0/export
> echo 0xFFF000 > /sys/class/pwm/pwmchip0/pwm0/period
> echo 0x7FF800 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
> echo 0xFFF000 > /sys/class/pwm/pwmchip0/pwm1/period
> echo 0x7FF800 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
> echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
> echo 1 > /sys/class/pwm/pwmchip0/pwm1/enable
>=20
> Now both LEDs are on, let's increase the period.
>=20
> echo 0xFFFF000 > /sys/class/pwm/pwmchip0/pwm0/period
> echo 0x7FFF800 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
>=20
> The effective period did not change.

Yeah, so pwm0 still runs at 0xFFF000. And setting the duty_cycle to
0x7FFF800 also results in it being 0xFFF000.
=20
> echo 0xFFFF000 > /sys/class/pwm/pwmchip0/pwm1/period
> echo 0x7FFF800 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
>=20
> The effective period didn't change now either.
>=20
> echo 0 > /sys/class/pwm/pwmchip0/pwm0/enable
> echo 0 > /sys/class/pwm/pwmchip0/pwm1/enable
>=20
> echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
> echo 1 > /sys/class/pwm/pwmchip0/pwm1/enable
>=20
> After turning the PWMs off and on again, the effective period is
> updated.

Yes, let's note that the sysfs API is strange.

> If we were to change the period dynamically to the smallest one, the
> LEDs would have changed their effective period without needing to be
> turned off and on again.

Not all consumers only care about the relative duty cycle. So changing
the period behind the back of a consumer even when keeping the relative
duty cycle is a no go.

> Would this approach be better than the current approach? I can see that
> other drivers just refuse updating the period entirely when the PWM
> channels must share the same period.
>=20
>=20
> 2)
>=20
> Another issue that I've encountered is that PWM is left enabled even if
> the channel is unexported.
>=20
> Here is an example.
>=20
> echo 0 > /sys/class/pwm/pwmchip0/export
> echo 0xFFFF000 > /sys/class/pwm/pwmchip0/pwm0/period
> echo 0x7FFF800 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
> echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
> echo 0 > /sys/class/pwm/pwmchip0/unexport
>=20
> The connected LED is kept blinking as 0 was not written to enable.
>=20
> Is this intended? Or should the PWM turn off on unexport?

For in-kernel users of a PWM it's the consumer's responsibility to
disable a PWM before pwm_put(). I think it's more natural to have the
same for /sys (and also the chardev interface).

> 3)
>=20
> Should the .get_state() ops read the period and duty cycle from the
> hardware if the PWM is not enabled?

It doesn't need to.

> Currently the MTU3 driver guards reading period and duty cycle based on
> whether the PWM is enabled.

Best regards
Uwe

--73k3u4jandqqyizn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmpQ4oACgkQj4D7WH0S
/k7iMAgAu3Ml0H8KBG9SsCnSyS32BCqDIneFx3upsHvm+1/N1Byeof1cdv/5Thov
pJ2JwexrpimVz643rpBvkZ/utEkmbIbDW5NOp8GlD0HK6G56sr2HhZ4r9cktv5bQ
YmNoTfwT2JJpC/MsZnrk2olNf1w4nRtL1WcFCEAmfFAYYBSyUB62VUq/huYh5fyC
whkeOgQ55YOmHZ0vVr2F7ksvo1AI0sJgJglmdwvhB9lUiB/FuRw1f+oqv55V8J73
rUqcGV6EHDStiimRD6bxJ95obAq2pT5zzlzjaK8Ctjg3/0fOasUBD3kB6EuwUbAo
fn7FrqywEgUnBZ5vXnav8uNmiHVWQw==
=01q9
-----END PGP SIGNATURE-----

--73k3u4jandqqyizn--

