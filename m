Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7772AF956
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 20:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgKKT55 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 14:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKT54 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 14:57:56 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F014C0613D1;
        Wed, 11 Nov 2020 11:57:56 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so3692487wrw.10;
        Wed, 11 Nov 2020 11:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EV1zSZnxeiNj7AdewMQkRMYjJy+CWcSEMHO0hUOUs1g=;
        b=BYAbyz12Cz9TX5VbWQlkl8fmK5Fth8vSaoEBODOtR3POui1l/yUsOz1f/d75S9pXyX
         TTd1d02z6d7dykDCCljYgKPcqFxj1iPVc+GNzP15xgcJ4ZDXfMTEyeOZyymFj5v8rgRG
         J8KEp+ZHqliuSq2YhpqHs7lqEPF2MDRhzhfZrrjiTdhtb+0Wof9XjR3iZj8hRCl7+JTh
         QFm2wLcax2M20+ko7SaOdyl9MevKbPfGhcacEZRALfdriDbci732XmH26nIvXbKfo3ts
         JUjw7PWwbLTlyWI1AuBwSQf5hfbmBe1BQtBQHILm8+0rzGR7OkrMIfizdHnqmkPkomYg
         zSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EV1zSZnxeiNj7AdewMQkRMYjJy+CWcSEMHO0hUOUs1g=;
        b=PvBrHzqg1Q68a534VrgTLdud06+F3qDCATE//5bcMDByKwKcDYlH/wkyawtX/xtqS8
         l9AATYd0hbPt5+2ouyn0ZkMMhyVjVfu6Fe6LZJzZ1sc9D6FOw/rss5mdArfAn0lz1H/k
         i7SoqeoKuYv6hRgCspMnd8H5E/HvqmgB7VBv3aqdLYXr6eUDufTXsZusBRtoCB0skAKU
         BXGZOEFkoiQvxeBW0oLppxoqzg05Cx8x+nD+yLAKKFY8otSFgDPsZiVLOvSXeAge4OjQ
         XXJeOkeEunvQzqUOp9EOf+ARJJ9Z3YvWD0A+aa7gujcMe8kWFIl/ByitItTx2bvG0Ogx
         mKoQ==
X-Gm-Message-State: AOAM530jpzJqG+P1voIIAS0rL6ra0145HLkaNJR904WjNt4jNTqsLWkH
        d388dkaWCXznVu9XtN1+on4=
X-Google-Smtp-Source: ABdhPJzOau2S3qcK5GwcPQnfWJSpcZjjqWa4TkPkvQLBdOY8oHN3aB17OhfrQLoetvMOqQaJJmJv6g==
X-Received: by 2002:adf:ea47:: with SMTP id j7mr31221822wrn.126.1605124674908;
        Wed, 11 Nov 2020 11:57:54 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id c2sm3875913wrf.68.2020.11.11.11.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:57:53 -0800 (PST)
Date:   Wed, 11 Nov 2020 20:57:52 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andy@infradead.org>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 0/3] pwm: lpss: pwm: lpss: Misc. cleanups /
 improvements
Message-ID: <20201111195752.GG6125@ulmo>
References: <20201109105726.121512-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Content-Disposition: inline
In-Reply-To: <20201109105726.121512-1-hdegoede@redhat.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 11:57:23AM +0100, Hans de Goede wrote:
> Hi All,
>=20
> Now that the pwm-lpss / pwm-crc / i915 atomic PWM conversion has landed
> in 5.10-rc1 here is a small follow up series with some misc. improvements.
>=20
> Changes in v2:
> - Extend comment to explain why the DPM_FLAG_SMART_SUSPEND is set
> - Add Andy's Reviewed-by to all 3 patches

All three patches applied, thanks.

Thierry

--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sQkAACgkQ3SOs138+
s6H2fw/9HXSDngw5gz4ME2lEQMcKkgSohMfps72q+1nh4EdtHmvmnOjCZ2/yJi5/
mGyPjAfh4TmGAkq1MKPA19Vb6qA4sxpYxo9SgiPPvMKgAO2RdrCONPWENinnqkai
Er7rdkgriRGonWOUOAE/K8hIfXqmmCOfKPci7dXL8Z8SnK/qgwiI1m6hYWu6tqhb
ZHMwifMowBjsRNkumlBUU+pFubj7S8SBhn8pxHChJeSfUiLGrw739D+WMUv3sOaI
oSXeN60BZ/z1Pb9Rhb29FqogemwGaYakeWE7Kox5C1QmxsD/PNkyMlvAUsZ2PkeL
uWZZj6DZ2L28cDKn3nIazUPLJcptCof1rEzZhaiVV/HM/fTX9CzT30w7Z7e/xHCS
DuXbFS+NFmyyxnMTszR6iTP4yC/cFBQBaUEkeMZHkbtxU9wmvTX4mRXcT5mod9II
62jN8qJajGHaZv8LMZawjE1Ik0RPVJPZcUl2y29HTbAxsEf23KQlfnh222sE8hmf
GJkX5bXR9HW4Ge6vPnBGHQV5DiYXWonOOu+TGK/+ljTEpRBBYHCIpFwwA0H05U4S
9iH3nHiEnPoYBSk2V+8wmdU0j7vI4TzDD70tRa0rRMTmcYacQgNoxn49gHaEBJFz
lkNezK1iHgOiCEU8uQ0qNkqq3uWtQ03XHm6Vb4pQPjjUgNjvy+4=
=wc6m
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--
