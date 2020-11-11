Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8298B2AEDC3
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 10:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgKKJ3u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 04:29:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56398 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgKKJ3t (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 04:29:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AB99meS132651;
        Wed, 11 Nov 2020 09:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5jkDrh9VUno5wDztTu7VDqalYM6QsS2FNOf4jWeicfM=;
 b=KF1FscfSPqR/jGnEnLVwcEnqGoTHFz4Z2rOgEGN8IMIFxCLnarNmEf6yLZt+ubgc38ju
 FF6+4F5J68sfFBDifPqGnH5V3uPfk4w6FD5FUr0QS2M/Zdgwq3QISc6uHMw4K+crIWBZ
 ONnZvtCoT0yED3aryMEFwF8QMGQ8kCWuXGE+ZzejvBwaV98VPCaKj4q8/Jm2eCyVb7sS
 0immoY8DntMHZsgAYS5RiANXtfW+vb+GUtthRzQTWbtXxy8A/ct0GwGlCNpnAmiN35xV
 +MFF8KI2mIgs2JJHTTFMaUrCEPh7GBQi8YyI0SPwXnsO/TJHMLq8dD9Hgr9flHokCiDv Zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34p72ep4py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 09:28:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AB9BEYR035947;
        Wed, 11 Nov 2020 09:28:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34p55pqrs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 09:28:55 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AB9Sllj029705;
        Wed, 11 Nov 2020 09:28:47 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Nov 2020 01:28:47 -0800
Date:   Wed, 11 Nov 2020 12:28:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Peter Chen <Peter.Chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devel@driverdev.osuosl.org, linux-samsung-soc@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-tegra@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 11/30] drm/tegra: dc: Support OPP and SoC core voltage
 scaling
Message-ID: <20201111092832.GI29398@kadam>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-12-digetx@gmail.com>
 <20201110202945.GF2375022@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110202945.GF2375022@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110051
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 10, 2020 at 09:29:45PM +0100, Thierry Reding wrote:
> > +	err = dev_pm_opp_of_add_table(dc->dev);
> > +	if (err) {
> > +		dev_err(dc->dev, "failed to add OPP table: %d\n", err);
> > +		goto put_hw;
> > +	}
> > +
> > +	err = devm_add_action(dc->dev, tegra_dc_deinit_opp_table, dc);
> > +	if (err)
> > +		goto remove_table;
> 
> Do these functions return positive values? If not, I'd prefer if this
> check was more explicit (i.e. err < 0) for consistency with the rest of
> this code.
> 

Isn't it the other way around?  It's only when the check is explicitly
for "if (ret < 0)" that we have to wonder about positives. If the codes
says "if (ret)" then we know that it doesn't return positive values and
every non-zero is an error.

In the kernel "if (ret)" is way more popular than "if (ret < 0)":

    $ git grep 'if (\(ret\|rc\|err\))' | wc -l
    92927
    $ git grep 'if (\(ret\|rc\|err\) < 0)' | wc -l
    36577

And some of those are places where "ret" can be positive so we are
forced to use the "if (ret < 0)" format.

Checking for "if (ret)" is easier from a static analysis perspective.
If it's one style is used consistently then they're the same but when
there is a mismatch the "if (ret < 0) " will trigger a false positive
and the "if (ret) " will not.

	int var;

	ret = frob(&var);
	if (ret < 0)
		return ret;

Smatch thinks positive returns are not handled so it complains that
"var can be uninitialized".

regards,
dan carpenter

