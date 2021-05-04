Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98088372C3E
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhEDOls convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 4 May 2021 10:41:48 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:44448 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhEDOlo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 May 2021 10:41:44 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 27BE01C0B9B; Tue,  4 May 2021 16:40:47 +0200 (CEST)
Date:   Tue, 4 May 2021 16:39:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH v7 1/6] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <YJFcsRnki3XT3isk@mobian>
References: <20210429211517.312792-1-bjorn.andersson@linaro.org>
 <20210429211517.312792-2-bjorn.andersson@linaro.org>
 <635d3f2c-d3a8-c0d6-7659-c22e44103901@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <635d3f2c-d3a8-c0d6-7659-c22e44103901@codeaurora.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi!
On Mon 2021-05-03 18:01:09, Subbaraman Narayanamurthy wrote:
> On 4/29/21 2:15 PM, Bjorn Andersson wrote:
> > This adds the binding document describing the three hardware blocks
> > related to the Light Pulse Generator found in a wide range of Qualcomm
> > PMICs.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
...
> > +      "^led@[0-9a-f]$":
> > +        type: object
> > +        $ref: common.yaml#
> > +
> 
> 
> Just a question more than a comment. From what I can see, when this device is specified as a multi-color device or an individual device (e.g. "red", "green" and "blue"), the user can only set "pattern" and "repeat" under the corresponding device after setting "pattern" to "trigger". Would you be planning to add a way (e.g. another set of DT properties) for the user to specify such patterns via the devicetree itself?
>

Please trim your replies and format emails to 72 columns or so.

If you need patterns in DTS that can be discussed, but it should be
generic functionality not tied to one driver.

Best regards,

       	    	 	     	    	      	 	 Pavel
-- 
