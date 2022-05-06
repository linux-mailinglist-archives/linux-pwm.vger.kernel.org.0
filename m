Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B663251DF21
	for <lists+linux-pwm@lfdr.de>; Fri,  6 May 2022 20:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245716AbiEFSfM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 May 2022 14:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244282AbiEFSfL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 May 2022 14:35:11 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D491A6D877;
        Fri,  6 May 2022 11:31:27 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-ed8a3962f8so8065178fac.4;
        Fri, 06 May 2022 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hUetKZxl7Z6yBeFbQUBFPspuukeJvS16RQz0Z44BiCQ=;
        b=m5JysbSVOuauUjUNKpeBUKW/doIc2XM4MVaH4/X7pUU5jf4TiEVEqae+gW3iCDsxy5
         3EQ9Rvcknpu+EENa3yfm0a5ZERmPxgD6LDbA8dt4j2nsYCtBMk+r/qnzRFHsJL2edlNr
         Z44cWQ3ZhCDXCQnKBjmWMrB9aWO5+6iZMbEnqOEySJ7sq1czLCqEhwyIcXETgV9JDgTG
         +Bjh1mFKvHL3wmfHVamaxciKKD0Wg5wKbo/5zYmy1gIfw7O/xjU1HiroV6ATI1DMWrh9
         iLjZyvr9RXts2gG4JbI1YG7fRqtd6feB1UD7kYEgsEUTAflAfeYIVOe2WlXvndVrdgdf
         i0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=hUetKZxl7Z6yBeFbQUBFPspuukeJvS16RQz0Z44BiCQ=;
        b=FFSQ0TKMDvI+Mn4SfF95PI98qEtbQbLjUdVH7QcdHPo1kcfEvrzKbAg2RoUZS9jJK3
         KrUGdymbp0V0vqAA5UNoRw55UHk2wbhjIR1ygPtEfAGo4PgupnhCnkLBUZxsq7OEoP73
         z6Tn8Gy5c9dQwTWzHAGc2dx/XTrtXlNr0+tjl1CUkl0SpTtLBQzKMOIsrIr5e8uf18KF
         vCSEWVub8v6JiqTPxLfcNIR1cy4sW4IZD1PaLlCxCg0wScrOhjF9KbSd6ToeFtMIChc7
         cYyzmCwA7UT4Pf9wchEVqj8ismKAWQVj31u2pWkAcdaAsANm//VXWdNimSkmWFhP/ICu
         b/zA==
X-Gm-Message-State: AOAM5327CQH+AnaSsiV+IvZ8HgI/in1VL06pkRFn2wiDrITKkZzhVwhK
        5BqVMgr7joELVv8TN5K++Ww=
X-Google-Smtp-Source: ABdhPJxPK/1EqvBi7rdX83PTBmIvmy5zFUJouO8JL88esjMcooZT3pQrvkIYNYX/H83nV+FgyB4rUw==
X-Received: by 2002:a05:6870:d5a2:b0:de:f682:6c4d with SMTP id u34-20020a056870d5a200b000def6826c4dmr1911306oao.283.1651861887149;
        Fri, 06 May 2022 11:31:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f25-20020a056870899900b000e686d13879sm1845496oaq.19.2022.05.06.11.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 11:31:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 6 May 2022 11:31:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH v2 1/1] hwmon: pwm-fan:
 dynamically switch regulator
Message-ID: <20220506183124.GA2997799@roeck-us.net>
References: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com>
 <2371611.jE0xQCEvom@steina-w>
 <20220506102301.my2tsn7kfldwqtll@pengutronix.de>
 <3417990.V25eIC5XRa@steina-w>
 <20220506141244.GA2990519@roeck-us.net>
 <20220506142913.vbddyvkmhuvfd5o5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506142913.vbddyvkmhuvfd5o5@pengutronix.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 06, 2022 at 04:29:13PM +0200, Uwe Kleine-König wrote:
> [Dropped Bartlomiej Zolnierkiewicz from Cc:; my mailer daemon claims the
> email address doens't exist.]
> 
> Hello Guenter,
> 
> On Fri, May 06, 2022 at 07:12:44AM -0700, Guenter Roeck wrote:
> > On Fri, May 06, 2022 at 02:23:11PM +0200, Alexander Stein wrote:
> > > Am Freitag, 6. Mai 2022, 12:23:01 CEST schrieb Uwe Kleine-König:
> > > > See
> > > > https://lore.kernel.org/linux-pwm/20180806155129.cjcc7okmwtaujf43@pengutronix.de/
> > > > for one of the previous discussions.
> > > 
> > > Thanks for the link. I took a look into it. I'm on your side here, IMHO 
> > > pwm_disable() implies that the PWM perphery is disabled, including any clocks 
> > > or powerdomain. This is what pwm-imx27 actually does. This might lead to a, 
> > > probably platform dependent, (undefined?) state of the PWM output pin.
> > > This implies it is not possible to disable the PWM periphery for inverted 
> > > signals, if the disabled state is not the inactive level. You know all about 
> > > it already.
> > > Then again from pwm-fan side I want be able to disable the FAN, turning of 
> > > regulator and PWM, so powersaving is possible. That's what this patch is 
> > > about. This is similar also what pwm_bl is doing.
> > > Independent of the exact semantics, it makes sense to disable the regulator in 
> > > pwm-fan as well when the fan shall be disabled.
> > 
> > There are fans which never stop if pwm==0, such as some CPU fans. I don't
> 
> I assume with pwm==0 you actually mean duty_cycle == 0?
> 

Correct. The "pwm" attribute sets the duty cycle.

> > think it is a good idea to force those off by turning off their power. The
> > problem in the driver is that it treats pwm==0 as "disable pwm", not as
> > "set pwm output to 0", Part of the probem may be that the ABI doesn't have
> > a good representation for "disable pwm output", which is what is really
> > wanted/needed here.
> 
> Disable pwm output == set pwm output to High-Z? Not all PWMs are able to
> provide that.
> 

It is up to us to define whate it means exactly. If you are ok that "set duty
cycle to 0" reflects "set duty cycle to 0, disable pwm, and turn off regulator",
I would hope that you are ok with using the _enable attribute to do the same
and leaving pwm==0 to do what it is supposed to do, ie to keep pwm control
enabled and set the duty cycle to 0.

Thanks,
Guenter

> > I think the best solution would be to implement and
> > use pwmX_enable, and define in the driver documentation that pwm1_enable=0
> > reflects "disable pwm" and pwm1_enable=1 reflects "emable manual pwm
> > control:. At the same time, stop associating "pwm==0" with "disable pwm",
> > but just set the pwm output value to 0.
> 
> Are you talking about the PWM framework here, or only the pwm-fan
> driver?
> 
> I'd expect there are better names than pwm1_enable for the intended
> semantic.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


