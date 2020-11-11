Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B17D2AF9D1
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 21:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgKKUdw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 15:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKKUdw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 15:33:52 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1B6C0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 12:33:51 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 10so3441158wml.2
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 12:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QSLZ3V4qYfP9bBUFIKHDdAufCeiSNEV6L7DOafw6q2U=;
        b=Hiquyf7gQZEeT6G8I9iQWX7B6k9MpG7inKIEf7Mu555H+zbmpAC4p5pDYkvK4IjDOj
         G1Pky2uGXsq2SVH0YviqL/RlzBWq40UguWk18Uvru88O1M9J4j+l20qEnyuvBCoLCySf
         YPWQ/fWngfpR1u8izDXHYI5bl6V4DSUvzk5Ffz7wbSbet8xcv3HC+lf+o03RRVOfi+4v
         U3+gxXnlluIfVIJKB70l6lB+LQ/y2YxOcNf+rU91POswh+odI9wrnzBLaMjkLNtBcogW
         sCN+sZFrKB3g6UUHJAahqVkxbfu+XL2kqINd3kna0yColPrfJWq8SBmi3jH6Vbu6iENk
         UKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QSLZ3V4qYfP9bBUFIKHDdAufCeiSNEV6L7DOafw6q2U=;
        b=YAnPCPh9eBEOtJHDQzsYyDgc40eGB9REZ5OhLI7pzdRfdUewWDC0Uu8j9y+Dn4GLT4
         P0J6TqF69u0+TBkWhGM53rgh2LqMus9S1YtgnrcpH24VVWPUTUCts0gbGdWbCLDFg9KY
         SrZ5iHMA7aCB1siNhkgXqPSjaD+vU1TXnU6qHY2z7Qcue2rXAZLNzbVDmlunFED3Xvyc
         vDuh3X4H3fma5IaptNg8boUrSSXgtWKVkFZjuS8ZlI5TW8x5b7yry4d+k2/bI0Tf1XMk
         bkdUTUkEYhEE3IzeIcv5hsM3z3lv3EUOTpcSsM8uYQg1sJvWnUe6PTmZ4Vc/Pr3mcR/G
         a1nQ==
X-Gm-Message-State: AOAM531yMtPqfEgaL086GoGs6togNRKQnm4AOI0+cS9t0x5a8f+5smvo
        J4bjHoKgIuqj0hzLG7fIEp8=
X-Google-Smtp-Source: ABdhPJxyvOSCT94L6ETGs7O0DXTPd3n1zq6dUTGrbxcQbcivE9+dHJ6Epm9d3VTRfL2xdd6OZ3IIzQ==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr6286602wmi.78.1605126830383;
        Wed, 11 Nov 2020 12:33:50 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id w11sm3798995wmg.36.2020.11.11.12.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:33:48 -0800 (PST)
Date:   Wed, 11 Nov 2020 21:33:47 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v4] pwm: Add DesignWare PWM Controller Driver
Message-ID: <20201111203347.GN6125@ulmo>
References: <20201002135613.999702-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="citGix+cyBYE+lqp"
Content-Disposition: inline
In-Reply-To: <20201002135613.999702-1-jarkko.nikula@linux.intel.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--citGix+cyBYE+lqp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2020 at 04:56:13PM +0300, Jarkko Nikula wrote:
> Introduce driver for Synopsys DesignWare PWM Controller used on Intel
> Elkhart Lake.
>=20
> Initial implementation is done by Felipe Balbi while he was working at
> Intel with later changes from Raymond Tan and me.
>=20
> Co-developed-by: Felipe Balbi (Intel) <balbi@kernel.org>
> Signed-off-by: Felipe Balbi (Intel) <balbi@kernel.org>
> Co-developed-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> v4. Resend with a minor cleanup
> - I guess previous version got lost since it's not visible in list
>   archive. I was told we have had some email issues
> - Make dev pointer assignment oneliner in probe
> v3. Previous version: https://www.spinics.net/lists/linux-pwm/msg12363.ht=
ml
> Changes:
> - I got confirmation specification is not publicly available
> - HW is actually fixed inversed polarity by the PWM framework
>   conventions: HW cycle begins with a low period. Fixed polarity and
>   low/high period calculation accordingly
> - Added range check to period and duty_cycle
> - Bogus '*' removed from head of the file comment
> - struct dwc_pwm * passed to readl/writel wrappers instead of __iomem *
> - %pe for error code prints
> - clk_period_ns removed from struct dwc_pwm and use DWC_CLK_PERIOD_NS ins=
tead
> - Device pointer removed from struct dwc_pwm, it's already carried in
>   struct pwm_chip
> - Added Limitations paragraph and commenting timer usage flow in code
> - duty_cycle and period capping to 32-bit removed from
>   dwc_pwm_get_state() since PWM core has been converted to 64-bit
> - s/DIV_ROUND_CLOSEST/DIV_ROUND_CLOSEST_ULL/ to fix a link error on
>   32-bit ARM and older GCC-9 build. Reported by kernel test robot
>   <lkp@intel.com> on an internal tree
> - Random cleanups, empty line removals etc
> v2. First version here https://www.spinics.net/lists/linux-pwm/msg12122.h=
tml
> Thanks to Uwe Kleine-K=C3=B6nig for good review comments, hopefully I cap=
tured
> them all.
> Changes:
> - Added Felipe's Signed-of-by. I added (Intel) to his kernel.org address
>   to highlight contribution was done while working at Intel
> - Version register read removed as result was unused
> - Order of dwc_pwm_writel() arguments changed to match with writel()
> - Structure initializers use one space instead of tab alignment
> - Error messages added to dwc_pwm_probe()
> - MODULE_LICENSE() Updated based on a review comment and commit bf7fbeeae=
6db
>   ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
> - Polarity handled. HW supports only normal polarity and driver errors
>   out in case of wrong polarity in dwc_pwm_apply() and returns fixed
>   normal polarity in dwc_pwm_get_state()
> - Running timers are not stopped on probe and remove. Those may be set
>   running by a bootloader and driver should leave them runnning
> - pwm_is_enabled() call changed to pwm->state.enabled in wc_pwm_apply()
> - Co-authors added to MODULE_AUTHOR() and comment
> - mutex removed
> - Add struct dwc_pwm_ctx for register save/restore instead of word array
> - suspend prevented in case of active PWM consumers. Please note this
>   checks only PWMs enabled by Linux consumers and not the ones enabled
>   by bootloader
> - Duplicate linux/pm_runtime.h include removed
> - Only once used trivial functions moved to dwc_pwm_get_state()
> - struct dwc_pwm_driver_data removed and used hard coded properties
>   instead since currently driver supports single device type
> - Driver uses internally 64-bit duty and period calculation and caps
>   them to 32-bit ns max value for PWM core. HW supports 32-bit high and
>   low period counters with 10 ns resolution so HW can do ~42,9 s duty and
>   ~85.9 s period at maximum
> ---
>  drivers/pwm/Kconfig   |   9 ++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-dwc.c | 319 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 329 insertions(+)
>  create mode 100644 drivers/pwm/pwm-dwc.c

Applied, thanks.

Thierry

--citGix+cyBYE+lqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sSqsACgkQ3SOs138+
s6FyXw//YpMMOLnCH0PPIYTnbYqA09aubYKwsMWdifOevV1RwkuGDUWyRTJGsQFH
RTc5umgou7hP+MQS3QwzO0lw4mC1ujfcKHit60M2P6vxZlwYHLNztRC3fEmUiz56
hK7RHaqGGwHlHo8leo8yFOLQeGwHKQdQdBn5Xno247q8IamEFmpi15364C45R/jK
dFs7TKafv8rJQ86MFZSYA3hfzG8a+/uvMTvW4QWSIQ8qgD7sCSTtbOyPeqXZz+bZ
oIC69fDCvtP6z54OY+rebDntevA67KE/Qq0+RVsthl7VZoi9X4QyLHOJK6cWO/14
mFOnZGuwxDlP3pZCHrD2S6cCbuVu1ix8EDlAyvuvqmGhGj8KJ2WLFz5vYx9dRgE6
uCqcb+vs03k+kz8lBEq0NN/RFhfwPDuOSpG4HrB2LrWJNxNl4GYaaJWz8ytZ77Dm
BCOCzGEA0km2OEmsP+ri9BNg+ArTYXlA9u39uiHpVFirUF4/AqAvBsakZYL0+gMA
MOp/JkrZqqTHRoR3s6/wC1xRs+3CLOZ+hP72gvIuu+0dL4NQ2n7s3vnaigUSFj5x
QCpoy0FvqaGSrIOMQPcn12mG3siB/F6BdCcVznbyvVXqh4gLgi2NWsZLmupqGjvh
WWpzy0Ubn1IaemjTdLOOaJrWJih5TGw4wokviORhOX0cN8vUiTo=
=IUQO
-----END PGP SIGNATURE-----

--citGix+cyBYE+lqp--
