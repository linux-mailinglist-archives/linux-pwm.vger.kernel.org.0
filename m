Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F58A2D2C29
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 14:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgLHNot (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 08:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHNos (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Dec 2020 08:44:48 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A48C0613D6;
        Tue,  8 Dec 2020 05:44:08 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id cm17so17657672edb.4;
        Tue, 08 Dec 2020 05:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3iuEHdH1gNg101wR8DTEbjhE0rQvqljv1Z07XXcLgl0=;
        b=Q/5Ovgud/TY63bvbDD/TbQOfp4GoB0YAKgr9Rsq+2TWCHdb+CcLJFsuALmTRH8Zjz5
         3iL/Bh4CEWO5qgOCQQo2p/o+X+D4mXLyFfd2OqeL99vZuqGgIJNCQg06NTzMuDCOZGp7
         fqbAYOYST+NR8oBrtK1osZQroE/Ex7PgdCNgzk+lXxScSsA+JBdcPuPuNk2lZlQXiJ1q
         z6v36G2AuIPgZElJDalVGtbDoKSUV3K/tx1Wsq6FSk7+9OyLVh4TtzVWifWA8MvUckDt
         VtBCoLc99A2a1uhh4p6OsxdI+lWV9xC1Rpde8O/NPOkj3+9UvvdJRIbZ8wdv3uszIYKA
         AdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3iuEHdH1gNg101wR8DTEbjhE0rQvqljv1Z07XXcLgl0=;
        b=J/cBio8B+KyITfQb89GSiVZ8z/SqIFEW1AMOsN36qEj+lXullB+7mYbBj5ptSCdhfz
         B8ykzWiQsHum79EIUmxYdvrOn7RuhcMAn5pdce9/YctKD/+OTdjl9dWk2fUup8IHAc8/
         8rXN8Gr6p62PQPnEZSYXrTInhltVntho2HiCvnUsPawDssvI9tUjIl/ekSiso93yZZ/T
         RzcJykfQMAlTt7Q84lcVrbslZ39fq0KOMJKZRtVK49rjHsVTsPCf5muRB31TrEZSMS2z
         rf0mOqCOYK4/s+q5J+6u9nobK3N5J06Dajm4QA4GxpUtRrBDNS/m+1W2/JbLMSPRGkk9
         G0fw==
X-Gm-Message-State: AOAM530mQVUKXVy+ZAJQUvLn5Y4WH+1vqhERHuOYFV7Vzs8P3m4PhTGI
        W48OH9FNdOXe9WVA82F1Ra4=
X-Google-Smtp-Source: ABdhPJyacRhLin1x9o87tMyIYIu7lFRwaGJIoc/Kz1vgmt1xUJECtT0S1J78qmQuwicvxuDLa4pBQQ==
X-Received: by 2002:aa7:c3cf:: with SMTP id l15mr15029612edr.282.1607435047096;
        Tue, 08 Dec 2020 05:44:07 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id a13sm17053147edb.76.2020.12.08.05.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 05:44:04 -0800 (PST)
Date:   Tue, 8 Dec 2020 14:44:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <X8+DI7ZN7mXtsxv9@ulmo>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
 <X863KNo0IaekkU7q@workstation.tuxnet>
 <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
 <X89RgpTb3sBBI++w@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mrYU85tcYWs+7OgA"
Content-Disposition: inline
In-Reply-To: <X89RgpTb3sBBI++w@workstation.tuxnet>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mrYU85tcYWs+7OgA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 08, 2020 at 11:12:18AM +0100, Clemens Gruber wrote:
> Hello Uwe,
>=20
> On Tue, Dec 08, 2020 at 10:10:33AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Clemens,
> >=20
> > On Tue, Dec 08, 2020 at 12:13:44AM +0100, Clemens Gruber wrote:
> > > On Mon, Dec 07, 2020 at 11:00:25PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Mon, Dec 07, 2020 at 08:36:27PM +0100, Clemens Gruber wrote:
> > > > > The hardware readout may return slightly different values than th=
ose
> > > > > that were set in apply due to the limited range of possible presc=
ale and
> > > > > counter register values. If one channel is reconfigured with new =
duty
> > > > > cycle and period, the others will keep the same relative duty cyc=
le to
> > > > > period ratio as they had before, even though the per-chip / global
> > > > > frequency changed. (The PCA9685 has only one prescaler!)
> > > >=20
> > > > This is not acceptable, if you have two PWM outputs and a consumer
> > > > modifies one of them the other must change. So if this chip only
> > > > supports a single period length of all channels, the first consumer
> > > > enabling a channel defines the period to be used. All later consume=
rs
> > > > must live with that. (Also the first must be denied modifying the p=
eriod
> > > > if a second consumer has enabled its PWM.)
> > >=20
> > > Good idea, but is it OK to potentially break users relying on the old
> > > behavior ("the last one who changes the period wins") ?
> >=20
> > If this is already in the old code, this probably warrants a separate
> > fix, and yes, I consider this a severe bug. (Consider one channel
> > driving a motor and reconfiguring an LED modifies the motor's speed.)
>=20
> Yes, but a user could also be relying on the old behavior as follows:
> 1. Requests & enables pwm 0 for a backlight, using a period of 5000000ns
>    (does not care about the frequency as long as it does not flicker)
> 2. Requests & enables pwm 1 for a motor, using a period of 1000000ns
>    (does care about the frequency)
>=20
> In the previous kernel versions, this would work, but with your
> suggested change, (2) would fail and the motor would no longer work.
>=20
> We are basically changing "the last one to set the period wins" to "the
> first one to set the period wins".
>=20
> If we do it like this, I'll split it out so we can at least revert it if
> someone complains that it breaks his application, without reverting the
> whole series.

Yes, that makes sense to me. We do want to make sure that we don't have
these kinds of races for PWM controllers and other drivers already have
corresponding checks in place.

But I agree that if this is preserving the status quo, then yes, we
should follow up with a separate patch to add that check so that it can
be easily reverted if this indeed break.

Although, if we do get failures after this check has been introduced,
they should be considered bugs and fixed in the right place. Ultimately
this is something that board designers have hopefully already thought
about and if there are two PWM consumers they will usually be able to
run at a common period, in which case fixing these should be as easy as
finding that common period and, well, using it for both consumers.

Thierry

--mrYU85tcYWs+7OgA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/PgyEACgkQ3SOs138+
s6H0Hg/+IFCQPNudxTHOV8jXYr7yxNaRilxcSAkFrjMAUHpYuF+PW5lU4HiXlFrH
nKABwDGqHD8+KsGvQ+5VUVPVjC5/b6S4nckFRM07iJ3KZ9MdF9ShRaF0RWi3TSkG
zrXalJ6+lirrmB3Z2Io5uj1EA+HXMjPxuRuqKQ8l5vs2OpUK58ohDz+Fysjw0cpI
hj2T0Aq6lvyf/ZROI36yjYfVUYe6wBYCXDvViQTx4WcIdV2LfDJKiRRRiSICOCcp
hUUWBEprQrK77+ftRvDcvYFgiOoERo58NxDZYaLhi7foH8OF+xKIglJqOf5Kr0tM
FK/I+ag4V/NwKBV820O9Ahc6e/C5zMEcxxxcQ0kJBoIIRoRVi+r6b6fclPn8LZ2K
mCcuf4F+jjlIn8XSRHTwt9JgGkek25vDnyswOUe9R55td+H4oB+qUYAieWnvSmyn
c4l7rTlUiVmT3qnspGWfVoc4W+NprSqJIWVXcdLOUDLvz7VjHWpywf2BNYO/3jqy
XlV0MoummWi+41ie0IbF29SXhnepld1Wc6ErA9rHgVYbWeGOzrPxFZxYgP1oVaaq
a3keRmlEa4bkp/Mg6EehKcQvVF1QkhgmCzgCMdbgZWupKaZEQE6NX48lN+76VwN3
Z+Ym12DZ3bkLzTj+INa+Z4zC8iJeE+v8hCoCpIzJ5Sn1JIpbtv4=
=irwy
-----END PGP SIGNATURE-----

--mrYU85tcYWs+7OgA--
