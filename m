Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1979638C609
	for <lists+linux-pwm@lfdr.de>; Fri, 21 May 2021 13:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhEUL4d (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 May 2021 07:56:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1266 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhEUL4b (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 May 2021 07:56:31 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LBq2lM010665;
        Fri, 21 May 2021 11:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=ICccCUcHiI/NlOQzcspv0EMIIWz3vxatBM7L10aSbYM=;
 b=lq97fxoNufNIKNMeMFskegEYhsQ6c2BQCU/TSKLYxwesQJ6gGVvJZKzusIvm7L/XWYx+
 0m/XvLqFDoMRikaBjWAw5Lo9Jiv6V3gsq7piAsSDEgFJEEyRjBb990Zs8pNMCxg9cgX7
 o/rJ/5bocWFOrsFzB0gbvgUr2DzxlTIgM6hJhooZsZXJCS0M3K9sS5+l2m0Or7M6htQI
 R+G6IVHS5MnDd6vN74wbxd9+Ukh8E/TYZlqQBAIZFIdONtoswmojPK/6EFYjqLYgsr6u
 RUWEYd1tHgEVM8X4BpQdyQ35sT28tcXGHK7YbJ1wy7SPB4w85+3ONN/7KklNXPr6u4+0 lg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38n3dg0wvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 11:54:53 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14LBsq89015405;
        Fri, 21 May 2021 11:54:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38n492pjng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 11:54:52 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14LBspt8015386;
        Fri, 21 May 2021 11:54:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 38n492pjnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 11:54:51 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14LBsebu029226;
        Fri, 21 May 2021 11:54:44 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 May 2021 11:54:40 +0000
Date:   Fri, 21 May 2021 14:54:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "David A. Schleef" <ds@schleef.org>,
        Mori Hess <fmhess@users.sourceforge.net>,
        Truxton Fulton <trux@linode1.truxton.com>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 5/6] comedi: drivers: ni_mio_common: Move
 'range_ni_E_ao_ext' to where it is used
Message-ID: <20210521115431.GK1955@kadam>
References: <20210520122538.3470259-1-lee.jones@linaro.org>
 <20210520122538.3470259-6-lee.jones@linaro.org>
 <c69d39a0-bf9e-857d-93ba-73e2884fa4ad@mev.co.uk>
 <20210521072635.GY2549456@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210521072635.GY2549456@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: ekLLV8zzo3RnZAmO3YNxSVGBvOmQuO3f
X-Proofpoint-GUID: ekLLV8zzo3RnZAmO3YNxSVGBvOmQuO3f
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 21, 2021 at 08:26:35AM +0100, Lee Jones wrote:
> On Thu, 20 May 2021, Ian Abbott wrote:
> 
> > On 20/05/2021 13:25, Lee Jones wrote:
> > > ... and mark it as __maybe_unused since not all users of the
> > > header file reference it.
> > > 
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >   drivers/staging/comedi/drivers/ni_mio_common.c:163:35: warning: ‘range_ni_E_ao_ext’ defined but not used [-Wunused-const-variable=]
> > > 
> > > Cc: Ian Abbott <abbotti@mev.co.uk>
> > > Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: "David A. Schleef" <ds@schleef.org>
> > > Cc: Mori Hess <fmhess@users.sourceforge.net>
> > > Cc: Truxton Fulton <trux@truxton.com>
> > > Cc: linux-staging@lists.linux.dev
> > > Cc: linux-pwm@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >   drivers/comedi/drivers/ni_mio_common.c | 9 ---------
> > >   drivers/comedi/drivers/ni_stc.h        | 9 ++++++++-
> > >   2 files changed, 8 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/drivers/ni_mio_common.c
> > > index 4f80a4991f953..37615b4e2c10d 100644
> > > --- a/drivers/comedi/drivers/ni_mio_common.c
> > > +++ b/drivers/comedi/drivers/ni_mio_common.c
> > > @@ -160,15 +160,6 @@ static const struct comedi_lrange range_ni_M_ai_628x = {
> > >   	}
> > >   };
> > > -static const struct comedi_lrange range_ni_E_ao_ext = {
> > > -	4, {
> > > -		BIP_RANGE(10),
> > > -		UNI_RANGE(10),
> > > -		RANGE_ext(-1, 1),
> > > -		RANGE_ext(0, 1)
> > > -	}
> > > -};
> > > -
> > >   static const struct comedi_lrange *const ni_range_lkup[] = {
> > >   	[ai_gain_16] = &range_ni_E_ai,
> > >   	[ai_gain_8] = &range_ni_E_ai_limited,
> > > diff --git a/drivers/comedi/drivers/ni_stc.h b/drivers/comedi/drivers/ni_stc.h
> > > index fbc0b753a0f59..0822e65f709dd 100644
> > > --- a/drivers/comedi/drivers/ni_stc.h
> > > +++ b/drivers/comedi/drivers/ni_stc.h
> > > @@ -1137,6 +1137,13 @@ struct ni_private {
> > >   	u8 rgout0_usage;
> > >   };
> > > -static const struct comedi_lrange range_ni_E_ao_ext;
> > > +static const struct comedi_lrange __maybe_unused range_ni_E_ao_ext = {
> > > +	4, {
> > > +		BIP_RANGE(10),
> > > +		UNI_RANGE(10),
> > > +		RANGE_ext(-1, 1),
> > > +		RANGE_ext(0, 1)
> > > +	}
> > > +};
> > >   #endif /* _COMEDI_NI_STC_H */
> > > 
> > 
> > The "ni_stc.h" header is also included by "ni_mio_cs.c" which doesn't need
> > `range_ni_E_ao_ext` (admittedly, it was already pulling in a "tentative"
> > definition of the variable).
> > 
> > Thinking about it, I think it's probably better to move `range_ni_E_ao_ext`
> > from "ni_mio_common.c" into *both* "ni_atmio.c" and "ni_pcimio.c" (I think
> > we can live with the small amount of duplication), and to remove the
> > tentative definition from "ni_stc.h".
> 
> Happy to rework.
> 
> Am I taking this or Uwe's suggestion?

You should probably take Ian's suggestion because he is the maintainer
and I really doubt Uwe's will build.  :P  But Uwe is right that
including .c files is ugly.

regards,
dan carpenter

